class Application < ApplicationRecord
  DEFAULT_STATUS = 'applied'.freeze

  belongs_to :job
  has_many :events, class_name: 'ApplicationRelated::Event', dependent: :destroy
  has_many :notes, class_name: 'ApplicationRelated::Note', dependent: :destroy

  validates :candidate_name, presence: true

  scope :with_active_job, -> { joins(:job).where(jobs: { status: Job.statuses[:active] }) }

  after_touch { |event| UpdateJobMetricsJob.perform_async(event.job_id) }

  def status
    events.max { |e| e.created_at.to_i }&.status || DEFAULT_STATUS # supposed to be preloaded
  end
end
