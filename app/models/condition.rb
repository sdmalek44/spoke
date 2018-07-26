class Condition < ApplicationRecord
  validates :date, presence: true, uniqueness: true
  validates_presence_of :max_temperature
  validates_presence_of :mean_temperature
  validates_presence_of :min_temperature
  validates_presence_of :mean_humidity
  validates_presence_of :mean_visibility
  validates_presence_of :mean_wind_speed
  validates_presence_of :precipitation

  def self.ride_count_grouped_by_date_max_temperature
    joins("inner join trips on conditions.date = trips.start_date")
    .group(:date, :max_temperature).count
  end

  def self.ride_count_grouped_by_date_precipitation
    joins("inner join trips on conditions.date = trips.start_date")
    .group(:date, :precipitation).count
  end

  def self.ride_count_grouped_by_date_mean_wind_speed
    joins("inner join trips on conditions.date = trips.start_date")
    .group(:date, :mean_wind_speed).count
  end

  def self.ride_count_grouped_by_date_mean_visibility
    joins("inner join trips on conditions.date = trips.start_date")
    .group(:date, :mean_visibility).count
  end
end

# Condition.select('conditions.date, count(trips.id) as trip_count').joins("INNER JOIN trips ON conditions.date = trips.start_date").where("conditions.max_temperature between 30 and 39").group(:date, :id).order('trip_count')
# ride_count = Condition.joins("inner join trips on conditions.date = trips.start_date").group(:date, :max_temperature).count   # {[date, temp] => ride_count}
#
# rides_in_the_70s = ride_count.select {|date,temp| date >= 70 && date < 80}
