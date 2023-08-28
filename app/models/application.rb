class Application < ApplicationRecord
  DEFAULT_STATUS = :applied

  belongs_to :job
  has_many :events, class_name: 'ApplicationRelated::Event', dependent: :destroy
  has_many :notes, class_name: 'ApplicationRelated::Note', dependent: :destroy

  validates :candidate_name, presence: true

  # Duplicates(denormalizes) status in events to reduce calculations cost
  enum status: %i[applied interview hired rejected]

  scope :with_active_job, -> { joins(:job).where(jobs: { status: Job.statuses[:active] }) }
  scope :hired, ->(job_id) { where(status: statuses[:hired]).where(job_id:) }
  scope :rejected, ->(job_id) { where(status: statuses[:rejected]).where(job_id:) }
  scope :ongoing, ->(job_id) { where.not(status: [statuses[:hired], statuses[:rejected]]).where(job_id:) }

  # event creating triggers updating job metrics and applications status
  # to avoid complex querying
  after_touch { update_status! }

  # TODO: create field to store first_interview_date in applications table to avoid searching in events
  def first_interview_date
    events.select { |e| e.status == 'interview' } # supposed to be preloaded(avoiding n+1)
          .min { |e| e.created_at.to_i }&.created_at
  end

  def job_name
    job.title
  end

  private

  def update_status!
    current_status = events.last&.status || DEFAULT_STATUS
    update!(status: current_status)
    JobRelated::UpdateJobMetricsJob.perform_async(application.job_id)
  end
end
