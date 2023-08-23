# frozen_string_literal: true

class Job < ApplicationRecord
  has_many :events, class_name: 'JobRelated::Event'

  validates :title, :description, presence: true

  # These metrics might be calculated asynchronously in the future to avoid on-the-fly calculations with each request.
  # we could add a `status` field to the `jobs` table and schedule an asynchronous job (using Sidekiq or a similar tool)
  # to compute the actual status after each event's creating/updating
  def self.metrics_query
    query = <<~SQL.squish
      jobs.*,
      CASE WHEN EXISTS
        (SELECT 1 FROM job_events
         WHERE job_events.job_id = jobs.id AND job_events.status = #{JobRelated::Event.statuses[:active]})
      THEN 'activated'
      ELSE 'deactivated'
      END AS status
    SQL

    Job.select(query)
  end
end
