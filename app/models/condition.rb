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
    .where("max_temperature is not null or start_date is null")
    .group(:date, :max_temperature).count(:start_date)
  end

  def self.ride_count_grouped_by_date_precipitation
    joins("inner join trips on conditions.date = trips.start_date")
    .where("max_temperature is not null or start_date is null")
    .group(:date, :precipitation).count(:start_date)
  end

  def self.ride_count_grouped_by_date_mean_wind_speed
    joins("inner join trips on conditions.date = trips.start_date")
    .where("max_temperature is not null or start_date is null")
    .group(:date, :mean_wind_speed).count(:start_date)
  end

  def self.ride_count_grouped_by_date_mean_visibility
    joins("inner join trips on conditions.date = trips.start_date")
    .where("max_temperature is not null or start_date is null")
    .group(:date, :mean_visibility).count(:start_date)
  end
end
