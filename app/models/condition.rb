class Condition < ApplicationRecord
  validates :date, presence: true, uniqueness: true
  validates_presence_of :max_temperature
  validates_presence_of :mean_temperature
  validates_presence_of :min_temperature
  validates_presence_of :mean_humidity
  validates_presence_of :mean_visibility
  validates_presence_of :mean_wind_speed
  validates_presence_of :precipitation

  def self.highest_number_of_rides_on_a_day_in_max_temperature_range(temperature)
    ride_counts = joins("inner join trips on conditions.date = trips.start_date")
    .where("conditions.max_temperature between #{temperature} and #{temperature + 9}")
    .group(:start_date, :id)
    .order('count(trips.id) desc').count
    unless ride_counts.first.nil?
      ride_counts.first.last
    else
      0
    end
  end

  def self.lowest_number_of_rides_on_a_day_in_max_temperature_range(temperature)
    ride_counts = joins("inner join trips on conditions.date = trips.start_date")
    .where("conditions.max_temperature between #{temperature} and #{temperature + 9}")
    .group(:start_date, :id)
    .order('count(trips.id) asc').count
    unless ride_counts.first.nil?
      ride_counts.first.last
    else
      0
    end
  end

  def self.average_number_of_rides_on_a_day_in_max_temperature_range(temperature)
    ride_counts = joins("inner join trips on conditions.date = trips.start_date")
    .where("conditions.max_temperature between #{temperature} and #{temperature + 9}")
    if ride_counts.group(:start_date, :id).count.count > 0
      ride_counts.count / ride_counts.group(:start_date, :id).count.count
    else
      0
    end
  end
end
