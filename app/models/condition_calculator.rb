class ConditionCalculator
  attr_reader :ride_count_by_max_temp
  attr_reader :ride_count_by_precipitation
  attr_reader :ride_count_by_mean_wind_speed
  attr_reader :ride_count_by_mean_visibility

  def initialize
    @ride_count_by_max_temp ||= Condition.ride_count_grouped_by_date_max_temperature
    @ride_count_by_precipitation ||= Condition.ride_count_grouped_by_date_precipitation
    @ride_count_by_mean_wind_speed ||= Condition.ride_count_grouped_by_date_mean_wind_speed
    @ride_count_by_mean_visibility ||= Condition.ride_count_grouped_by_date_mean_visibility
  end

  def lowest_number_of_rides_on_a_day_in_max_temperature_range(max_temp)
    ride_count_in_range = ride_count_by_max_temp.select do |data, _|
      data[1] >= max_temp && data[1] < max_temp + 10
    end
    unless ride_count_in_range.empty?
      ride_count_in_range.values.min
    else
      0
    end
  end

  def highest_number_of_rides_on_a_day_in_max_temperature_range(max_temp)
    ride_count_in_range = ride_count_by_max_temp.select do |data, _|
      data[1] >= max_temp && data[1] < max_temp + 10
    end
    unless ride_count_in_range.empty?
      ride_count_in_range.values.max
    else
      0
    end
  end

  def average_number_of_rides_on_a_day_in_max_temperature_range(max_temp)
    ride_count_in_range = ride_count_by_max_temp.select do |data, _|
      data[1] >= max_temp && data[1] < max_temp + 10
    end
    if ride_count_in_range.values.length == 0
      0
    else
      ride_count_in_range.values.sum / ride_count_in_range.values.length.to_f
    end
  end

  def highest_number_of_rides_on_a_day_in_precipitation_range(precipitation)
    ride_count_in_range = ride_count_by_precipitation.select do |data, _|
      data[1] >= precipitation && data[1] < precipitation + 0.5
    end
    unless ride_count_in_range.empty?
      ride_count_in_range.values.max
    else
      0
    end
  end

  def lowest_number_of_rides_on_a_day_in_precipitation_range(precipitation)
    ride_count_in_range = ride_count_by_precipitation.select do |data, _|
      data[1] >= precipitation && data[1] < precipitation + 0.5
    end
    unless ride_count_in_range.empty?
      ride_count_in_range.values.min
    else
      0
    end
  end

  def average_number_of_rides_on_a_day_in_precipitation_range(precipitation)
    ride_count_in_range = ride_count_by_precipitation.select do |data, _|
      data[1] >= precipitation && data[1] < precipitation + 0.5
    end
    if ride_count_in_range.values.length == 0
      0
    else
      ride_count_in_range.values.sum / ride_count_in_range.values.length.to_f
    end
  end

  def highest_number_of_rides_on_a_day_in_mean_wind_speed_range(mean_wind_speed)
    ride_count_in_range = ride_count_by_mean_wind_speed.select do |data, _|
      data[1] >= mean_wind_speed && data[1] < mean_wind_speed + 4
    end
    unless ride_count_in_range.empty?
      ride_count_in_range.values.max
    else
      0
    end
  end

  def lowest_number_of_rides_on_a_day_in_mean_wind_speed_range(mean_wind_speed)
    ride_count_in_range = ride_count_by_mean_wind_speed.select do |data, _|
      data[1] >= mean_wind_speed && data[1] < mean_wind_speed + 4
    end
    unless ride_count_in_range.empty?
      ride_count_in_range.values.min
    else
      0
    end
  end

  def average_number_of_rides_on_a_day_in_mean_wind_speed_range(mean_wind_speed)
    ride_count_in_range = ride_count_by_mean_wind_speed.select do |data, _|
      data[1] >= mean_wind_speed && data[1] < mean_wind_speed + 4
    end
    if ride_count_in_range.values.length == 0
      0
    else
      ride_count_in_range.values.sum / ride_count_in_range.values.length.to_f
    end
  end

  def highest_number_of_rides_on_a_day_in_mean_visibility_range(mean_visibility)
    ride_count_in_range = ride_count_by_mean_visibility.select do |data, _|
      data[1] >= mean_visibility && data[1] < mean_visibility + 4
    end
    unless ride_count_in_range.empty?
      ride_count_in_range.values.max
    else
      0
    end
  end

  def lowest_number_of_rides_on_a_day_in_mean_visibility_range(mean_visibility)
    ride_count_in_range = ride_count_by_mean_visibility.select do |data, _|
      data[1] >= mean_visibility && data[1] < mean_visibility + 4
    end
    unless ride_count_in_range.empty?
      ride_count_in_range.values.min
    else
      0
    end
  end

  def average_number_of_rides_on_a_day_in_mean_visibility_range(mean_visibility)
    ride_count_in_range = ride_count_by_mean_visibility.select do |data, _|
      data[1] >= mean_visibility && data[1] < mean_visibility + 4
    end
    if ride_count_in_range.values.length == 0
      0
    else
      ride_count_in_range.values.sum / ride_count_in_range.values.length.to_f
    end
  end
end
