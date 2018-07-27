require 'rails_helper'

describe 'user visits trip show page' do
  it 'can see all of that trips attributes' do
    station1 = Station.create!(name: 'name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
    station2 = Station.create!(name: 'eman', dock_count: 30, city: 'ytic', installation_date: Date.new(2013, 2, 15))
    trip = Trip.create!(duration: 44, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 5), start_station_id: station1.id, end_station_id: station2.id, bike_id: 3, subscription_type: 1, zip_code: 68686)

    visit trip_path(trip)

    expect(page).to have_content(trip.duration)
    expect(page).to have_content(trip.end_date.strftime("%m/%d/%Y"))
    expect(page).to have_content(station1.name)
    expect(page).to have_content(trip.start_date.strftime("%m/%d/%Y"))
    expect(page).to have_content(station2.name)
    expect(page).to have_content(trip.bike_id)
    expect(page).to have_content(trip.subscription_type)
    expect(page).to have_content(trip.zip_code)
  end

  describe "an admin user visits '/trips/:id'" do
    before :each do
      user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles', role: 1, first_name: 'josh', last_name: 'mcbeth', address: '1111 tommy ln')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end
    it 'they see all the information a regular user can see' do
      station1 = Station.create!(name: 'name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
      station2 = Station.create!(name: 'eman', dock_count: 30, city: 'ytic', installation_date: Date.new(2013, 2, 15))
      trip_1 = Trip.create!(duration: 44, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 5), start_station_id: station1.id, end_station_id: station2.id, bike_id: 3, subscription_type: 0, zip_code: 67000)

      visit trip_path(trip_1)

      expect(page).to have_content("Duration: #{trip_1.duration}")
      expect(page).to have_content("Start Date: #{trip_1.start_date.strftime('%m/%d/%Y')}")
      expect(page).to have_content("End Date: #{trip_1.end_date.strftime('%m/%d/%Y')}")
      expect(page).to have_content("Start Station: #{trip_1.start_station.name}")
      expect(page).to have_content("End Station: #{trip_1.end_station.name}")
      expect(page).to have_content("Bike ID: #{trip_1.bike_id}")
      expect(page).to have_content("Subscription Type: #{trip_1.subscription_type}")
      expect(page).to have_content("Zip Code: #{trip_1.zip_code}")
    end
    it 'they see a button to edit that trip' do
      station1 = Station.create!(name: 'name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
      station2 = Station.create!(name: 'eman', dock_count: 30, city: 'ytic', installation_date: Date.new(2013, 2, 15))
      trip_1 = Trip.create!(duration: 44, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 5), start_station_id: station1.id, end_station_id: station2.id, bike_id: 3, subscription_type: 0, zip_code: 67000)

      visit trip_path(trip_1)

      click_button 'Edit'

      expect(current_path).to eq(edit_admin_trip_path(trip_1))
    end
    it 'they see a button to delete that trip' do
      station1 = Station.create!(name: 'name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
      station2 = Station.create!(name: 'eman', dock_count: 30, city: 'ytic', installation_date: Date.new(2013, 2, 15))
      trip_1 = Trip.create!(duration: 44, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 5), start_station_id: station1.id, end_station_id: station2.id, bike_id: 3, subscription_type: 0, zip_code: 67000)

      visit trip_path(trip_1)

      click_button 'Delete'

      expect(current_path).to eq(trips_path)
      expect(page).to have_content("Successfully deleted trip")
    end
  end
end
