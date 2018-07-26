require 'rails_helper'

describe Condition, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :date}
    it {should validate_presence_of :max_temperature}
    it {should validate_presence_of :mean_temperature}
    it {should validate_presence_of :min_temperature}
    it {should validate_presence_of :mean_humidity}
    it {should validate_presence_of :mean_visibility}
    it {should validate_presence_of :mean_wind_speed}
    it {should validate_presence_of :precipitation}
  end
  describe 'class methods' do
    it ".ride_count_grouped_by_date_max_temperature" do
      station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
      Condition.create(date: Date.new(2011, 2, 3), max_temperature: 75.0, mean_temperature: 65.0, min_temperature: 55.0, mean_humidity: 75.0, mean_visibility: 10.0, mean_wind_speed: 11.0, precipitation: 0.23)
      Condition.create(date: Date.new(2000, 1, 4), max_temperature: 70.0, mean_temperature: 60.0, min_temperature: 50.0, mean_humidity: 65.0, mean_visibility: 5.0, mean_wind_speed: 12.0, precipitation: 0.12)
      Condition.create(date: Date.new(2016, 11, 10), max_temperature: 78.0, mean_temperature: 66.0, min_temperature: 51.0, mean_humidity: 65.0, mean_visibility: 5.0, mean_wind_speed: 22.0, precipitation: 1.12)
      Condition.create(date: Date.new(2000, 2, 4), max_temperature: 77.0, mean_temperature: 68.0, min_temperature: 53.0, mean_humidity: 65.0, mean_visibility: 5.0, mean_wind_speed: 33.0, precipitation: 2.12)
      Trip.create(duration: 10, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_1.id, bike_id: 1, zip_code: 68686, subscription_type: 0)
      Trip.create(duration: 20, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_1.id, bike_id: 1, zip_code: 68686, subscription_type: 0)
      Trip.create(duration: 30, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_1.id, bike_id: 2, zip_code: 68686, subscription_type: 0)
      Trip.create(duration: 30, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_1.id, bike_id: 2, zip_code: 68686, subscription_type: 0)

      ride_count = Condition.ride_count_grouped_by_date_max_temperature

      expect(ride_count.class).to eq(Hash)
      expect(ride_count.length).to eq(2)
      expect(ride_count.keys[0].class).to eq(Array)
      expect(ride_count.values[0].class).to eq(Integer)
      expect(ride_count.values.max).to eq(3)
      expect(ride_count.values.min).to eq(1)
    end
    it ".ride_count_grouped_by_date_precipitation" do
      station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
      Condition.create(date: Date.new(2011, 2, 3), max_temperature: 75.0, mean_temperature: 65.0, min_temperature: 55.0, mean_humidity: 75.0, mean_visibility: 10.0, mean_wind_speed: 11.0, precipitation: 0.23)
      Condition.create(date: Date.new(2000, 1, 4), max_temperature: 70.0, mean_temperature: 60.0, min_temperature: 50.0, mean_humidity: 65.0, mean_visibility: 5.0, mean_wind_speed: 12.0, precipitation: 0.12)
      Condition.create(date: Date.new(2016, 11, 10), max_temperature: 78.0, mean_temperature: 66.0, min_temperature: 51.0, mean_humidity: 65.0, mean_visibility: 5.0, mean_wind_speed: 22.0, precipitation: 0.42)
      Condition.create(date: Date.new(2000, 2, 4), max_temperature: 77.0, mean_temperature: 68.0, min_temperature: 53.0, mean_humidity: 65.0, mean_visibility: 5.0, mean_wind_speed: 33.0, precipitation: 0.00)
      Trip.create(duration: 10, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_1.id, bike_id: 1, zip_code: 68686, subscription_type: 0)
      Trip.create(duration: 20, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_1.id, bike_id: 1, zip_code: 68686, subscription_type: 0)
      Trip.create(duration: 30, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_1.id, bike_id: 2, zip_code: 68686, subscription_type: 0)
      Trip.create(duration: 30, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_1.id, bike_id: 2, zip_code: 68686, subscription_type: 0)

      ride_count = Condition.ride_count_grouped_by_date_precipitation

      expect(ride_count.class).to eq(Hash)
      expect(ride_count.length).to eq(2)
      expect(ride_count.keys[0].class).to eq(Array)
      expect(ride_count.values[0].class).to eq(Integer)
      expect(ride_count.values.max).to eq(3)
      expect(ride_count.values.min).to eq(1)
    end
    it ".ride_count_grouped_by_date_mean_wind_speed" do
      station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
      Condition.create(date: Date.new(2011, 2, 3), max_temperature: 75.0, mean_temperature: 65.0, min_temperature: 55.0, mean_humidity: 75.0, mean_visibility: 10.0, mean_wind_speed: 11.0, precipitation: 0.23)
      Condition.create(date: Date.new(2000, 1, 4), max_temperature: 70.0, mean_temperature: 60.0, min_temperature: 50.0, mean_humidity: 65.0, mean_visibility: 5.0, mean_wind_speed: 12.0, precipitation: 0.12)
      Condition.create(date: Date.new(2016, 11, 10), max_temperature: 78.0, mean_temperature: 66.0, min_temperature: 51.0, mean_humidity: 65.0, mean_visibility: 5.0, mean_wind_speed: 13.0, precipitation: 0.42)
      Condition.create(date: Date.new(2000, 2, 4), max_temperature: 77.0, mean_temperature: 68.0, min_temperature: 53.0, mean_humidity: 65.0, mean_visibility: 5.0, mean_wind_speed: 14.0, precipitation: 0.00)
      Trip.create(duration: 10, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_1.id, bike_id: 1, zip_code: 68686, subscription_type: 0)
      Trip.create(duration: 20, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_1.id, bike_id: 1, zip_code: 68686, subscription_type: 0)
      Trip.create(duration: 30, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_1.id, bike_id: 2, zip_code: 68686, subscription_type: 0)
      Trip.create(duration: 30, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_1.id, bike_id: 2, zip_code: 68686, subscription_type: 0)

      ride_count = Condition.ride_count_grouped_by_date_mean_wind_speed

      expect(ride_count.class).to eq(Hash)
      expect(ride_count.length).to eq(2)
      expect(ride_count.keys[0].class).to eq(Array)
      expect(ride_count.values[0].class).to eq(Integer)
      expect(ride_count.values.max).to eq(3)
      expect(ride_count.values.min).to eq(1)
    end
    it ".average_number_of_rides_on_a_day_in_mean_visibility_range" do
      station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
      Condition.create(date: Date.new(2011, 2, 3), max_temperature: 75.0, mean_temperature: 65.0, min_temperature: 55.0, mean_humidity: 75.0, mean_visibility: 4.0, mean_wind_speed: 11.0, precipitation: 0.23)
      Condition.create(date: Date.new(2000, 1, 4), max_temperature: 70.0, mean_temperature: 60.0, min_temperature: 50.0, mean_humidity: 65.0, mean_visibility: 5.0, mean_wind_speed: 12.0, precipitation: 0.12)
      Condition.create(date: Date.new(2016, 11, 10), max_temperature: 78.0, mean_temperature: 66.0, min_temperature: 51.0, mean_humidity: 65.0, mean_visibility: 6.0, mean_wind_speed: 13.0, precipitation: 0.42)
      Condition.create(date: Date.new(2000, 2, 4), max_temperature: 77.0, mean_temperature: 68.0, min_temperature: 53.0, mean_humidity: 65.0, mean_visibility: 7.0, mean_wind_speed: 14.0, precipitation: 0.00)
      Trip.create(duration: 10, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_1.id, bike_id: 1, zip_code: 68686, subscription_type: 0)
      Trip.create(duration: 20, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_1.id, bike_id: 1, zip_code: 68686, subscription_type: 0)
      Trip.create(duration: 30, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_1.id, bike_id: 2, zip_code: 68686, subscription_type: 0)
      Trip.create(duration: 30, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_1.id, bike_id: 2, zip_code: 68686, subscription_type: 0)

      ride_count = Condition.ride_count_grouped_by_date_mean_visibility

      expect(ride_count.class).to eq(Hash)
      expect(ride_count.length).to eq(2)
      expect(ride_count.keys[0].class).to eq(Array)
      expect(ride_count.values[0].class).to eq(Integer)
      expect(ride_count.values.max).to eq(3)
      expect(ride_count.values.min).to eq(1)
    end
  end
end
