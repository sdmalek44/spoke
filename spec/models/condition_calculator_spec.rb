require 'rails_helper'

describe ConditionCalculator do
  before :each do
    station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
    Condition.create(date: Date.new(2011, 2, 3), max_temperature: 75.0, mean_temperature: 65.0, min_temperature: 55.0, mean_humidity: 75.0, mean_visibility: 4.0, mean_wind_speed: 11.0, precipitation: 0.23)
    Condition.create(date: Date.new(2000, 1, 4), max_temperature: 70.0, mean_temperature: 60.0, min_temperature: 50.0, mean_humidity: 65.0, mean_visibility: 5.0, mean_wind_speed: 12.0, precipitation: 0.12)
    Condition.create(date: Date.new(2016, 11, 10), max_temperature: 78.0, mean_temperature: 66.0, min_temperature: 51.0, mean_humidity: 65.0, mean_visibility: 6.0, mean_wind_speed: 13.0, precipitation: 0.42)
    Condition.create(date: Date.new(2000, 2, 4), max_temperature: 77.0, mean_temperature: 68.0, min_temperature: 53.0, mean_humidity: 65.0, mean_visibility: 7.0, mean_wind_speed: 10.0, precipitation: 0.00)
    Trip.create(duration: 10, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_1.id, bike_id: 1, zip_code: 68686, subscription_type: 0)
    Trip.create(duration: 20, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_1.id, bike_id: 1, zip_code: 68686, subscription_type: 0)
    Trip.create(duration: 30, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_1.id, bike_id: 2, zip_code: 68686, subscription_type: 0)
    Trip.create(duration: 30, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_1.id, bike_id: 2, zip_code: 68686, subscription_type: 0)
    @conditions = ConditionCalculator.new
  end
  it "calculates min, max, average number of rides for a day for max_temperature" do
    max_ride_count = @conditions.highest_number_of_rides_on_a_day_in_max_temperature_range(70)
    min_ride_count = @conditions.lowest_number_of_rides_on_a_day_in_max_temperature_range(70)
    avg_ride_count = @conditions.average_number_of_rides_on_a_day_in_max_temperature_range(70)

    expect(max_ride_count).to eq(3)
    expect(min_ride_count).to eq(1)
    expect(avg_ride_count).to eq(2)
  end
  it "calculates min, max, average number of rides for a day for precipitation" do
    max_ride_count = @conditions.highest_number_of_rides_on_a_day_in_precipitation_range(0)
    min_ride_count = @conditions.lowest_number_of_rides_on_a_day_in_precipitation_range(0)
    avg_ride_count = @conditions.average_number_of_rides_on_a_day_in_precipitation_range(0)

    expect(max_ride_count).to eq(3)
    expect(min_ride_count).to eq(1)
    expect(avg_ride_count).to eq(2)
  end
  it "calculates min, max, average number of rides for a day for mean_wind_speed" do
    max_ride_count = @conditions.highest_number_of_rides_on_a_day_in_mean_wind_speed_range(10)
    min_ride_count = @conditions.lowest_number_of_rides_on_a_day_in_mean_wind_speed_range(10)
    avg_ride_count = @conditions.average_number_of_rides_on_a_day_in_mean_wind_speed_range(10)

    expect(max_ride_count).to eq(3)
    expect(min_ride_count).to eq(1)
    expect(avg_ride_count).to eq(2)
  end
  it "calculates min, max, average number of rides for a day for mean_visibility" do
    max_ride_count = @conditions.highest_number_of_rides_on_a_day_in_mean_visibility_range(4)
    min_ride_count = @conditions.lowest_number_of_rides_on_a_day_in_mean_visibility_range(4)
    avg_ride_count = @conditions.average_number_of_rides_on_a_day_in_mean_visibility_range(4)

    expect(max_ride_count).to eq(3)
    expect(min_ride_count).to eq(1)
    expect(avg_ride_count).to eq(2)
  end
end
