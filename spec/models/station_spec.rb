require 'rails_helper'

describe Station, type: :model do
  describe 'relationships' do
    it {should have_many :trips}
    it {should have_many :statuses}
  end
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :dock_count}
    it {should validate_presence_of :city}
    it {should validate_presence_of :installation_date}
  end
  describe 'class methods' do
    it 'can get total_count of stations' do
      Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
      Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))

      expect(Station.total_count).to eq(2)
    end
    it 'can get total_count of stations' do
      station1 = Station.create!(name: '1name', dock_count: 1, city: 'city1', installation_date: Date.new(2017, 3, 10))
      station2 = Station.create!(name: '2name', dock_count: 3, city: 'city2', installation_date: Date.new(2017, 3, 10))

      expect(Station.average_bikes_per_station).to eq(2)
    end
    it 'can get station with most bikes' do
      station1 = Station.create!(name: '1name', dock_count: 1, city: 'city1', installation_date: Date.new(2017, 3, 10))
      station2 = Station.create!(name: '2name', dock_count: 3, city: 'city2', installation_date: Date.new(2017, 3, 10))

      expect(Station.station_with_most_bikes).to eq(station2)
    end
    it 'can get station with least bikes' do
      station1 = Station.create!(name: '1name', dock_count: 1, city: 'city1', installation_date: Date.new(2015, 3, 10))
      station2 = Station.create!(name: '2name', dock_count: 3, city: 'city2', installation_date: Date.new(2017, 3, 10))

      expect(Station.station_with_least_bikes).to eq(station1)
    end
    it 'most recently installed station' do
      station1 = Station.create!(name: '1name', dock_count: 1, city: 'city1', installation_date: Date.new(2015, 3, 10))
      station2 = Station.create!(name: '2name', dock_count: 3, city: 'city2', installation_date: Date.new(2017, 3, 10))

      expect(Station.newest_station).to eq(station2)
    end
    it 'oldest station' do
      station1 = Station.create!(name: '1name', dock_count: 1, city: 'city1', installation_date: Date.new(2015, 1, 10))
      station2 = Station.create!(name: '2name', dock_count: 3, city: 'city2', installation_date: Date.new(2017, 3, 10))

      expect(Station.oldest_station).to eq(station1)
    end
  end
  describe 'instance methods' do
      it 'can calculate amount of trips started at station' do
      station = Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
      Trip.create!(duration: 44, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 5), start_station_id: station.id, end_station_id: station.id, bike_id: 3, subscription_type: 1, zip_code: 68686)
      Trip.create!(duration: 44, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 5), start_station_id: station.id, end_station_id: station.id, bike_id: 3, subscription_type: 1, zip_code: 68686)

      expect(station.rides_started_here).to eq(2)
    end
    it 'can calculate amount of trips ended at station' do
      station = Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
      Trip.create!(duration: 44, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 5), start_station_id: station.id, end_station_id: station.id, bike_id: 3, subscription_type: 1, zip_code: 68686)
      Trip.create!(duration: 44, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 5), start_station_id: station.id, end_station_id: station.id, bike_id: 3, subscription_type: 1, zip_code: 68686)

      expect(station.rides_ended_here).to eq(2)
    end
    it 'can calculate most frequent destination station for trips that started at station' do
      station1 = Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
      station2 = Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
      Trip.create!(duration: 44, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 5), start_station_id: station1.id, end_station_id: station2.id, bike_id: 3, subscription_type: 1, zip_code: 68686)
      Trip.create!(duration: 44, start_date: Date.new(2020, 2, 4), end_date: Date.new(2020, 2, 5), start_station_id: station1.id, end_station_id: station2.id, bike_id: 3, subscription_type: 1, zip_code: 68686)
      Trip.create!(duration: 44, start_date: Date.new(2030, 2, 4), end_date: Date.new(2030, 2, 5), start_station_id: station1.id, end_station_id: station1.id, bike_id: 3, subscription_type: 1, zip_code: 68686)

      expect(station1.frequent_destination_station).to eq(station2)
    end
    it 'can calculate most frequent origination station for trips that started at station' do
      station1 = Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
      station2 = Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
      Trip.create!(duration: 44, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 5), start_station_id: station2.id, end_station_id: station1.id, bike_id: 3, subscription_type: 1, zip_code: 68686)
      Trip.create!(duration: 44, start_date: Date.new(2020, 2, 4), end_date: Date.new(2020, 2, 5), start_station_id: station2.id, end_station_id: station1.id, bike_id: 3, subscription_type: 1, zip_code: 68686)
      Trip.create!(duration: 44, start_date: Date.new(2030, 2, 4), end_date: Date.new(2030, 2, 5), start_station_id: station1.id, end_station_id: station1.id, bike_id: 3, subscription_type: 1, zip_code: 68686)

      expect(station1.frequent_origination_station).to eq(station2)
    end
    it 'can calculate most frequent origination date for trips that started at station' do
      station1 = Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
      station2 = Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
      date = Date.new(2000, 2, 4)

      Trip.create!(duration: 44, start_date: date, end_date: Date.new(2000, 2, 5), start_station_id: station1.id, end_station_id: station1.id, bike_id: 3, subscription_type: 1, zip_code: 68686)
      Trip.create!(duration: 44, start_date: date, end_date: Date.new(2000, 2, 5), start_station_id: station1.id, end_station_id: station1.id, bike_id: 3, subscription_type: 1, zip_code: 68686)
      Trip.create!(duration: 44, start_date: Date.new(2010, 2, 4), end_date: Date.new(2010, 2, 5), start_station_id: station1.id, end_station_id: station1.id, bike_id: 3, subscription_type: 1, zip_code: 68686)

      expect(station1.date_with_most_trips).to eq(date)
    end
    it 'can calculate most frequent origination zip for trips that started at station' do
      station1 = Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
      station2 = Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
      date = Date.new(2000, 2, 4)

      Trip.create!(duration: 44, start_date: date, end_date: Date.new(2000, 2, 5), start_station_id: station1.id, end_station_id: station1.id, bike_id: 3, subscription_type: 1, zip_code: 55555)
      Trip.create!(duration: 44, start_date: date, end_date: Date.new(2000, 2, 5), start_station_id: station1.id, end_station_id: station1.id, bike_id: 3, subscription_type: 1, zip_code: 55555)
      Trip.create!(duration: 44, start_date: Date.new(2010, 2, 4), end_date: Date.new(2010, 2, 5), start_station_id: station1.id, end_station_id: station1.id, bike_id: 3, subscription_type: 1, zip_code: 44444)

      expect(station1.zip_code_with_most_trips).to eq(55555)
    end
    it 'can calculate most frequent origination zip for trips that started at station' do
      station1 = Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
      station2 = Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
      date = Date.new(2000, 2, 4)

      Trip.create!(duration: 44, start_date: date, end_date: Date.new(2000, 2, 5), start_station_id: station1.id, end_station_id: station1.id, bike_id: 3, subscription_type: 1, zip_code: 55555)
      Trip.create!(duration: 44, start_date: date, end_date: Date.new(2000, 2, 5), start_station_id: station1.id, end_station_id: station1.id, bike_id: 3, subscription_type: 1, zip_code: 55555)
      Trip.create!(duration: 44, start_date: Date.new(2010, 2, 4), end_date: Date.new(2010, 2, 5), start_station_id: station1.id, end_station_id: station1.id, bike_id: 2, subscription_type: 1, zip_code: 44444)

      expect(station1.bike_id_with_most_trips).to eq(3)
    end
  end
end
