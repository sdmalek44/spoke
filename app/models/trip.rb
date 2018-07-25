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

  belongs_to :start_station, class_name: 'Station', foreign_key: :start_station_id, dependent: :destroy
  belongs_to :end_station, class_name: 'Station', foreign_key: :end_station_id, dependent: :destroy

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
    station = select('start_station_id, COUNT(start_station_id) AS start_station_count')
    .group(:start_station_id)
    .order('start_station_count DESC')
    .limit(1)
    .first
    Station.find(station.start_station_id)
  end

  def self.most_frequent_end_station
    station_id = select('end_station_id, COUNT(end_station_id) AS end_station_count')
    .group(:end_station_id)
    .order('end_station_count DESC')
    .limit(1)
    .first
    Station.find(station_id.end_station_id)
  end

  def self.rides_per_month
    group("date_trunc('month', start_date)").order('count_all DESC').count
  end

  def self.rides_per_year
    group("date_trunc('year', start_date)").order('count_all DESC').count
  end

  def self.most_ridden_bike
    most_ridden_bike = select('bike_id, COUNT(bike_id) AS ride_count')
    .group(:bike_id)
    .order('ride_count DESC')
    .limit(1)
    .first
    {most_ridden_bike.bike_id => most_ridden_bike.ride_count}
  end

  def self.least_ridden_bike
    least_ridden_bike = select('bike_id, COUNT(bike_id) AS ride_count')
    .group(:bike_id)
    .order('ride_count ASC')
    .limit(1)
    .first
    {least_ridden_bike.bike_id => least_ridden_bike.ride_count}
  end

  def self.subscription_type_count
    group(:subscription_type).count
  end

  def self.date_with_most_rides
    date_rides = group(:start_date).order('count_all DESC').count.first
    {date: date_rides.first, rides: date_rides.last}
  end

  def self.date_with_least_rides
    date_rides = group(:start_date).order('count_all ASC').count.first
    {date: date_rides.first, rides: date_rides.last}
  end
end
