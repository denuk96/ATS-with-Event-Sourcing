# frozen_string_literal: true

class Job < ApplicationRecord
  has_many :events, class_name: 'JobRelated::Event', dependent: :destroy
  has_many :applications, dependent: :destroy

  validates :title, :description, presence: true

  enum status: %i[active deactivated]

  def update_metrics!
    params = {
      status: events.last&.status || JobRelated::Event.statuses[:deactivated],
      hired: applications.hired(id).count,
      rejected: applications.rejected(id).count,
      ongoing: applications.ongoing(id).count
    }

    update!(params)
  end
end
