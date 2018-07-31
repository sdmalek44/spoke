require 'rails_helper'

describe Trip, type: :model do
  describe 'validations' do
    it {should validate_presence_of :duration}
    it {should validate_presence_of :start_date}
    it {should validate_presence_of :end_date}
    it {should validate_presence_of :subscription_type}
    it {should validate_presence_of :zip_code}
    it {should validate_presence_of :start_station_id}
    it {should validate_presence_of :end_station_id}
  end
  describe 'relationships' do
    it {should belong_to :start_station}
    it {should belong_to :end_station}
  end
  describe 'Class Methods' do
    it '.duration_info' do
      station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
      station_2 = Station.create(name: 'Test 2', dock_count: 25, city: 'Chicago', installation_date: Date.new(2017, 11, 11))

      trip_1 = Trip.create!(duration: 10, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)
      trip_2 = Trip.create!(duration: 20, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)
      trip_3 = Trip.create!(duration: 30, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)

      expect(Trip.duration_info).to eq([30, 20, 10])
    end

    it '.station_info' do
      station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
      station_2 = Station.create(name: 'Test 2', dock_count: 25, city: 'Chicago', installation_date: Date.new(2017, 11, 11))

      trip_1 = Trip.create!(duration: 10, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)
      trip_2 = Trip.create!(duration: 20, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)
      trip_3 = Trip.create!(duration: 30, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_2.id, end_station_id: station_1.id, bike_id: 1, subscription_type: 0, zip_code: 68686)

      expect(Trip.station_info).to eq({most_frequent_start_station: station_1, most_frequent_end_station: station_2})
    end

    it '.rides_per_month' do
      station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
      station_2 = Station.create(name: 'Test 2', dock_count: 25, city: 'Chicago', installation_date: Date.new(2017, 11, 11))

      trip_1 = Trip.create!(duration: 10, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)
      trip_2 = Trip.create!(duration: 20, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)
      trip_3 = Trip.create!(duration: 30, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_2.id, end_station_id: station_1.id, bike_id: 1, subscription_type: 0, zip_code: 68686)

      expect(Trip.rides_per_month.first.to_s).to eq("[2000-01-01 00:00:00 UTC, 2]")
      expect(Trip.rides_per_month.to_a.last.to_s).to eq("[2000-02-01 00:00:00 UTC, 1]")
    end

    it '.rides_per_year' do
      station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
      station_2 = Station.create(name: 'Test 2', dock_count: 25, city: 'Chicago', installation_date: Date.new(2017, 11, 11))

      trip_1 = Trip.create!(duration: 10, start_date: Date.new(2001, 1, 1), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)
      trip_2 = Trip.create!(duration: 20, start_date: Date.new(2001, 1, 1), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)
      trip_3 = Trip.create!(duration: 30, start_date: Date.new(2002, 1, 1), end_date: Date.new(2000, 2, 4), start_station_id: station_2.id, end_station_id: station_1.id, bike_id: 1, subscription_type: 0, zip_code: 68686)

      expect(Trip.rides_per_year.first.to_s).to eq("[2001-01-01 00:00:00 UTC, 2]")
      expect(Trip.rides_per_year.to_a.last.to_s).to eq("[2002-01-01 00:00:00 UTC, 1]")
    end

    it '.bike_info' do
      station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
      station_2 = Station.create(name: 'Test 2', dock_count: 25, city: 'Chicago', installation_date: Date.new(2017, 11, 11))

      trip_1 = Trip.create!(duration: 10, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)
      trip_2 = Trip.create!(duration: 20, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)
      trip_3 = Trip.create!(duration: 30, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_2.id, end_station_id: station_1.id, bike_id: 2, subscription_type: 0, zip_code: 68686)

      expect(Trip.bike_info).to eq({:most_ridden_bike=>[nil, 2], :least_ridden_bike=>[nil, nil, 1]})
    end

    it '.subscription_type_info' do
      station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
      station_2 = Station.create(name: 'Test 2', dock_count: 25, city: 'Chicago', installation_date: Date.new(2017, 11, 11))

      trip_1 = Trip.create!(duration: 10, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, zip_code: 68686)
      trip_2 = Trip.create!(duration: 20, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, zip_code: 68686, subscription_type: 1)
      trip_3 = Trip.create!(duration: 30, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_2.id, end_station_id: station_1.id, bike_id: 2, zip_code: 68686, subscription_type: 1)

      expect(Trip.subscription_type_info).to eq([{'Customer'=> 1, 'Subscriber' => 2}, 3])
    end

    it '.date_info' do
      station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
      station_2 = Station.create(name: 'Test 2', dock_count: 25, city: 'Chicago', installation_date: Date.new(2017, 11, 11))

      start_date = Date.new(2000, 1, 4)

      condition_1 = Condition.create(date: Date.new(2000, 1, 4), max_temperature: 75.0, mean_temperature: 65.0, min_temperature: 55.0, mean_humidity: 75.0, mean_visibility: 10.0, mean_wind_speed: 11.0, precipitation: 0.23)
      condition_2 = Condition.create(date: Date.new(2000, 2, 4), max_temperature: 70.0, mean_temperature: 60.0, min_temperature: 50.0, mean_humidity: 65.0, mean_visibility: 5.0, mean_wind_speed: 12.0, precipitation: 0.12)

      trip_1 = Trip.create!(duration: 10, start_date: start_date, end_date: Date.new(2000, 1, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, zip_code: 68686)
      trip_2 = Trip.create!(duration: 20, start_date: start_date, end_date: Date.new(2000, 1, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, zip_code: 68686)
      trip_3 = Trip.create!(duration: 30, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_2.id, end_station_id: station_1.id, bike_id: 2, zip_code: 68686)

      expect(Trip.date_info[:most_rides][:date].strftime('%m/%d/%Y')).to eq(start_date.strftime('%m/%d/%Y'))
      expect(Trip.date_info[:least_rides][:date].strftime('%m/%d/%Y')).to eq(Date.new(2000, 2, 4).strftime('%m/%d/%Y'))
      expect(Trip.date_info[:most_rides][:rides]).to eq(2)
      expect(Trip.date_info[:least_rides][:rides]).to eq(1)
      expect(Trip.date_info[:most_rides][:condition]).to eq(condition_1)
      expect(Trip.date_info[:least_rides][:condition]).to eq(condition_2)
    end
  end
end
