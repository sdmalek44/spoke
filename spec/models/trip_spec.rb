require 'rails_helper'

describe Trip, type: :model do
  describe 'relationships' do
    it {should belong_to :start_station}
    it {should belong_to :end_station}
  end
  describe 'validations' do
    it {should validate_presence_of :duration}
    it {should validate_presence_of :start_date}
    it {should validate_presence_of :end_date}
    it {should validate_presence_of :subscription_type}
    it {should validate_presence_of :zip_code}
    it {should validate_presence_of :start_station_id}
    it {should validate_presence_of :end_station_id}
  end
  describe 'instance methods' do
    it 'can return the start station name' do
      station1 = Station.create!(name: 'name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
      station2 = Station.create!(name: 'eman', dock_count: 30, city: 'ytic', installation_date: Date.new(2013, 2, 15))
      trip = Trip.create!(duration: 44, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 5), start_station_id: station1.id, end_station_id: station2.id, bike_id: 3, subscription_type: 1, zip_code: 68686)

      expect(trip.start_station).to eq(station1)
    end
    it 'can return the end station name' do
      station1 = Station.create!(name: 'name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
      station2 = Station.create!(name: 'eman', dock_count: 30, city: 'ytic', installation_date: Date.new(2013, 2, 15))
      trip = Trip.create!(duration: 44, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 5), start_station_id: station1.id, end_station_id: station2.id, bike_id: 3, subscription_type: 1, zip_code: 68686)

      expect(trip.end_station).to eq(station2)
    end
  end
end
