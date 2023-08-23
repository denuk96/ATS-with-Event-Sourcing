# frozen_string_literal: true

class Job < ApplicationRecord
  has_many :events, class_name: 'JobRelated::Event', dependent: :destroy
  has_many :applications, dependent: :destroy

  validates :title, :description, presence: true

  enum status: %i[active deactivated]

  def update_metrics!
    params = {
      status: events.last&.status || JobRelated::Event.statuses[:deactivated],
      hired: total_hired,
      rejected: total_rejected,
      ongoing: total_ongoing
    }

    update!(params)
  end

  def total_hired
    applications.joins(:events)
                .where(events: { status: ApplicationRelated::Event.statuses[:hired] })
                .count
  end

  def total_rejected
    applications.joins(:events)
                .where(events: { status: ApplicationRelated::Event.statuses[:rejected] })
                .count
  end

  def total_ongoing
    # Since each Application might have multiple events, we determine the application's status by its latest event.
    # Therefore, we need to skip all except the last one
    # However, it might be more reasonable to add a 'status' field to the 'applications' table
    # and update it asynchronously using the Event#after_save callback, similar to how Job#update_metrics! is implemented
    # and then simply calc by statuses avoiding complex query like below
    latest_event_subquery = ApplicationRelated::Event.select('DISTINCT ON(application_id) application_id, status')
                                                     .order('application_id, created_at DESC')
    applications.left_joins(:events)
                .joins("LEFT JOIN (#{latest_event_subquery.to_sql}) AS latest_events
                        ON applications.id = latest_events.application_id")
                .where('latest_events.application_id IS NULL OR latest_events.status NOT IN (?)',
                       [ApplicationRelated::Event.statuses[:rejected], ApplicationRelated::Event.statuses[:hired]])
                .count
  end
end
