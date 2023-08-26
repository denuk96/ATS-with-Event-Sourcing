module ApplicationRelated
  class Note < ApplicationRecord
    self.table_name = 'application_notes'
    belongs_to :application, counter_cache: true

    validates :content, presence: true
  end
end
