# frozen_string_literal: true

module JobRelated
  class Event < ApplicationRecord
    self.table_name = 'job_events'

    belongs_to :job

    enum status: %i[active deactivated]

    after_save { |event| UpdateJobMetricsJob.perform_async(event.job_id) }
  end
end
