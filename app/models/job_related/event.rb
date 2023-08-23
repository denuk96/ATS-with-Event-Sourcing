# frozen_string_literal: true

module JobRelated
  class Event < ApplicationRecord
    self.table_name = 'job_events'

    belongs_to :job

    enum status: %i[active deactivated]
  end
end
