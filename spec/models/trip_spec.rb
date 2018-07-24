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
    it '.average_ride_duration' do
      station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
      station_2 = Station.create(name: 'Test 2', dock_count: 25, city: 'Chicago', installation_date: Date.new(2017, 11, 11))

      trip_1 = Trip.create!(duration: 10, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)
      trip_2 = Trip.create!(duration: 20, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)
      trip_3 = Trip.create!(duration: 30, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)

      expect(Trip.average_ride_duration).to eq(20)
    end

    it '.longest_ride_duration' do
      station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
      station_2 = Station.create(name: 'Test 2', dock_count: 25, city: 'Chicago', installation_date: Date.new(2017, 11, 11))

      trip_1 = Trip.create!(duration: 10, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)
      trip_2 = Trip.create!(duration: 20, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)
      trip_3 = Trip.create!(duration: 30, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)

      expect(Trip.longest_ride_duration).to eq(30)
    end

    it '.shortest_ride_duration' do
      station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
      station_2 = Station.create(name: 'Test 2', dock_count: 25, city: 'Chicago', installation_date: Date.new(2017, 11, 11))

      trip_1 = Trip.create!(duration: 10, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)
      trip_2 = Trip.create!(duration: 20, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)
      trip_3 = Trip.create!(duration: 30, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)

      expect(Trip.shortest_ride_duration).to eq(10)
    end

    it '.most_frequent_start_station' do
      station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
      station_2 = Station.create(name: 'Test 2', dock_count: 25, city: 'Chicago', installation_date: Date.new(2017, 11, 11))

      trip_1 = Trip.create!(duration: 10, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)
      trip_2 = Trip.create!(duration: 20, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)
      trip_3 = Trip.create!(duration: 30, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_2.id, end_station_id: station_1.id, bike_id: 1, subscription_type: 0, zip_code: 68686)

      expect(Trip.most_frequent_start_station).to eq(station_1)
    end

    it '.most_frequent_end_station' do
      station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
      station_2 = Station.create(name: 'Test 2', dock_count: 25, city: 'Chicago', installation_date: Date.new(2017, 11, 11))

      trip_1 = Trip.create!(duration: 10, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)
      trip_2 = Trip.create!(duration: 20, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)
      trip_3 = Trip.create!(duration: 30, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_2.id, end_station_id: station_1.id, bike_id: 1, subscription_type: 0, zip_code: 68686)

      expect(Trip.most_frequent_end_station).to eq(station_2)
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

    it '.most_ridden_bike' do
      station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
      station_2 = Station.create(name: 'Test 2', dock_count: 25, city: 'Chicago', installation_date: Date.new(2017, 11, 11))

      trip_1 = Trip.create!(duration: 10, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)
      trip_2 = Trip.create!(duration: 20, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)
      trip_3 = Trip.create!(duration: 30, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_2.id, end_station_id: station_1.id, bike_id: 2, subscription_type: 0, zip_code: 68686)

      expect(Trip.most_ridden_bike).to eq(1 => 2)
    end

    it '.least_ridden_bike' do
      station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
      station_2 = Station.create(name: 'Test 2', dock_count: 25, city: 'Chicago', installation_date: Date.new(2017, 11, 11))

      trip_1 = Trip.create!(duration: 10, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)
      trip_2 = Trip.create!(duration: 20, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)
      trip_3 = Trip.create!(duration: 30, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_2.id, end_station_id: station_1.id, bike_id: 2, subscription_type: 0, zip_code: 68686)

      expect(Trip.least_ridden_bike).to eq(2 => 1)
    end

    it '.subscription_types' do
      station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
      station_2 = Station.create(name: 'Test 2', dock_count: 25, city: 'Chicago', installation_date: Date.new(2017, 11, 11))

      trip_1 = Trip.create!(duration: 10, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, zip_code: 68686)
      trip_2 = Trip.create!(duration: 20, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, zip_code: 68686, subscription_type: 1)
      trip_3 = Trip.create!(duration: 30, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_2.id, end_station_id: station_1.id, bike_id: 2, zip_code: 68686, subscription_type: 1)

      expect(Trip.subscription_type_count).to eq({'customer'=> 1, 'subscriber' => 2})
    end

    it '.date_with_most_rides' do
      station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
      station_2 = Station.create(name: 'Test 2', dock_count: 25, city: 'Chicago', installation_date: Date.new(2017, 11, 11))

      start_date = Date.new(2000, 1, 4)

      trip_1 = Trip.create!(duration: 10, start_date: start_date, end_date: Date.new(2000, 1, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, zip_code: 68686)
      trip_2 = Trip.create!(duration: 20, start_date: start_date, end_date: Date.new(2000, 1, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, zip_code: 68686)
      trip_3 = Trip.create!(duration: 30, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_2.id, end_station_id: station_1.id, bike_id: 2, zip_code: 68686)

      expect(Trip.date_with_most_rides.first).to eq("2000-01-04 00:00:00 UTC")
      expect(Trip.date_with_most_rides.last).to eq(2)
    end

    it '.date_with_least_rides' do
      station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
      station_2 = Station.create(name: 'Test 2', dock_count: 25, city: 'Chicago', installation_date: Date.new(2017, 11, 11))

      trip_1 = Trip.create!(duration: 10, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, zip_code: 68686)
      trip_2 = Trip.create!(duration: 20, start_date: Date.new(2000, 1, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 1, zip_code: 68686)
      trip_3 = Trip.create!(duration: 30, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 4), start_station_id: station_2.id, end_station_id: station_1.id, bike_id: 2, zip_code: 68686)

      expect(Trip.date_with_least_rides.first).to eq("2000-02-04 00:00:00 UTC")
      expect(Trip.date_with_least_rides.last).to eq(1)
    end
  end
end
