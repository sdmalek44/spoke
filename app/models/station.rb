class Station < ApplicationRecord
  extend FriendlyId
  validates_presence_of :name
  validates_presence_of :dock_count
  validates_presence_of :city
  validates_presence_of :installation_date

  has_many :trips
  has_many :trips, class_name: 'Trip', foreign_key: :start_station_id
  has_many :trips, class_name: 'Trip', foreign_key: :end_station_id
  has_many :statuses

  friendly_id :name, use: :slugged

  def self.total_count
    count
  end

  def self.average_bikes_per_station
    average(:dock_count).round(1)
  end

  def self.station_with_most_bikes
    order(:dock_count).last
  end

  def self.station_with_least_bikes
    order(:dock_count).first
  end

  def self.newest_station
    order(:installation_date).last
  end

  def self.oldest_station
    order(:installation_date).first
  end

  def rides_started_here
    Trip.where(start_station_id: id).count
  end

  def rides_ended_here
    Trip.where(end_station_id: id).count
  end

  def frequent_destination_station
    start_trips = Trip.where(start_station_id: id)
    end_trip = start_trips.select('end_station_id, COUNT(end_station_id) AS end_station_count')
                .group(:end_station_id)
                .order('end_station_count DESC')
                .limit(1)
                .first
    Station.find(end_trip.end_station_id)
  end

  def frequent_origination_station
    end_trips = Trip.where(end_station_id: id)
    start_trip = end_trips.select('start_station_id, COUNT(start_station_id) AS start_station_count')
                .group(:start_station_id)
                .order('start_station_count DESC')
                .limit(1)
                .first
    Station.find(start_trip.start_station_id)
  end

  def date_with_most_trips
    start_trips = Trip.where(start_station_id: id)
    start_trips.select('start_date, COUNT(start_date) AS start_date_count')
                .group(:start_date)
                .order('start_date_count DESC')
                .limit(1)
                .take
                .start_date
  end

  def zip_code_with_most_trips
    start_trips = Trip.where(start_station_id: id)
    start_trips.select('zip_code, COUNT(zip_code) AS zip_code_count')
                .group(:zip_code)
                .order('zip_code_count DESC')
                .limit(1)
                .take
                .zip_code
  end

  def bike_id_with_most_trips
    start_trips = Trip.where(start_station_id: id)
    start_trips.select('bike_id, COUNT(bike_id) AS bike_id_count')
                .group(:bike_id)
                .order('bike_id_count DESC')
                .limit(1)
                .take
                .bike_id
  end
end
