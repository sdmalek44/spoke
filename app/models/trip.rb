class Trip < ApplicationRecord
  validates_presence_of :duration
  validates_presence_of :start_date
  validates_presence_of :start_station_id
  validates_presence_of :end_date
  validates_presence_of :end_station_id
  validates_presence_of :bike_id
  validates_presence_of :subscription_type
  validates_presence_of :zip_code

  enum subscription_type: ['customer', 'subscriber']

  belongs_to :start_station, class_name: 'Station', foreign_key: :start_station_id
  belongs_to :end_station, class_name: 'Station', foreign_key: :end_station_id

  def self.average_ride_duration
    average(:duration)
  end

  def self.longest_ride_duration
    maximum(:duration)
  end

  def self.shortest_ride_duration
    minimum(:duration)
  end
end
