class Trip < ApplicationRecord
  validates_presence_of :duration
  validates_presence_of :start_date
  validates_presence_of :start_station_id
  validates_presence_of :end_date
  validates_presence_of :end_station_id
  validates_presence_of :bike_id
  validates_presence_of :subscription_type
  validates_presence_of :zip_code

  enum subscription_type: ['Customer', 'Subscriber']

  belongs_to :start_station, class_name: 'Station', foreign_key: :start_station_id, dependent: :destroy
  belongs_to :end_station, class_name: 'Station', foreign_key: :end_station_id, dependent: :destroy

  def self.duration_info
    [maximum(:duration), average(:duration), minimum(:duration)]
  end

  def self.station_info
    stations = select('start_station_id, COUNT(start_station_id) AS start_station_count')
    .group(:start_station_id)
    .order('start_station_count DESC')
    {most_frequent_start_station: Station.find(stations.first.start_station_id),
     most_frequent_end_station: Station.find(stations.last.start_station_id)}
  end

  def self.rides_per_month
    group("date_trunc('month', start_date)").order('count_all DESC').count
  end

  def self.rides_per_year
    group("date_trunc('year', start_date)").order('count_all DESC').count
  end

  def self.bike_info
    ordered_bikes = select('bike_id, COUNT(bike_id) AS ride_count')
    .group(:bike_id)
    .order('ride_count DESC')
    {most_ridden_bike: [ordered_bikes.first.id, ordered_bikes.first.ride_count],
    least_ridden_bike: [ordered_bikes.last.id, ordered_bikes.last.id, ordered_bikes.last.ride_count]}
  end

  def self.subscription_type_info
    [group(:subscription_type).count, Trip.count]
  end

  def self.date_info
    date_rides = group(:start_date).order('count_all DESC').count
    condition_1 = Condition.find_by(date: date_rides.keys.first)
    condition_2 = Condition.find_by(date: date_rides.keys.last)
    x = {most_rides: {date: date_rides.keys.first, rides: date_rides.values.first, condition: condition_1},
     least_rides: {date: date_rides.keys.last, rides: date_rides.values.last, condition: condition_2}}
  end
end
