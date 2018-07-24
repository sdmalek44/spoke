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

  def self.most_frequent_start_station
    station_id = select('start_station_id, COUNT(start_station_id) AS start_station_count')
    .group(:start_station_id)
    .order('start_station_count DESC')
    .limit(1)
    .first
    Station.find(station_id.start_station_id)
  end

  def self.most_frequent_end_station
    station_id = select('end_station_id, COUNT(end_station_id) AS end_station_count')
    .group(:end_station_id)
    .order('end_station_count DESC')
    .limit(1)
    .first
    Station.find(station_id.end_station_id)
  end
end
