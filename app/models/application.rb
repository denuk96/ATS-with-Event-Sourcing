class Application < ApplicationRecord
  DEFAULT_STATUS = 'applied'.freeze

  belongs_to :job
  has_many :events, class_name: 'ApplicationRelated::Event', dependent: :destroy
  has_many :notes, class_name: 'ApplicationRelated::Note', dependent: :destroy

  validates :candidate_name, presence: true

  scope :with_active_job, -> { joins(:job).where(jobs: { status: Job.statuses[:active] }) }
  scope :hired, lambda { |job_id|
    joins(:events)
      .where(events: { status: ApplicationRelated::Event.statuses[:hired] })
      .where(job_id:)
  }
  scope :rejected, lambda { |job_id|
    joins(:events)
      .where(events: { status: ApplicationRelated::Event.statuses[:rejected] })
      .where(job_id:)
  }
  scope :ongoing, lambda { |job_id|
    # Since each Application might have multiple events, we determine the application's status by its latest event.
    # Therefore, we need to skip all except the last one
    # However, it might be more reasonable to add a 'status' field to the 'applications' table
    # and update it asynchronously using the Event#after_save callback, similar to how Job#update_metrics! is implemented
    # and then simply calc by statuses avoiding complex query like below
    latest_event_subquery = ApplicationRelated::Event.select('DISTINCT ON(application_id) application_id, status')
                                                      .order('application_id, created_at DESC')
    left_joins(:events)
      .joins("LEFT JOIN (#{latest_event_subquery.to_sql}) AS latest_events
                        ON applications.id = latest_events.application_id")
      .where('latest_events.application_id IS NULL OR latest_events.status NOT IN (?)',
             [ApplicationRelated::Event.statuses[:rejected], ApplicationRelated::Event.statuses[:hired]])
      .where(job_id:)
  }

  after_touch { |event| UpdateJobMetricsJob.perform_async(event.job_id) }

  def status
    events.max { |e| e.created_at.to_i }&.status || DEFAULT_STATUS # supposed to be preloaded
  end
end
