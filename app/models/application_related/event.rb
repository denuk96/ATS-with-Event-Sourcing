module ApplicationRelated
  class Event < ApplicationRecord
    self.table_name = 'application_events'

    belongs_to :application, touch: true
    has_one :job, through: :application

    enum status: %i[interview hired rejected]
  end
end
