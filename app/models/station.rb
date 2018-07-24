class Station < ApplicationRecord
  extend FriendlyId
  validates_presence_of :name
  validates_presence_of :dock_count
  validates_presence_of :city
  validates_presence_of :installation_date

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
    trips.where(start_station_id: id).length
  end

  def rides_ended_here
    trips.where(end_station_id: id).length
  end
end
