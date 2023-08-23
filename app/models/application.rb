class Application < ApplicationRecord
  belongs_to :job
  has_many :events, class_name: 'ApplicationRelated::Event', dependent: :destroy

  validates :candidate_name, presence: true

  after_touch { |event| UpdateJobMetricsJob.perform_async(event.job_id) }
end
