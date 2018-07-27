require 'rails_helper'

describe "Admin user visits '/admin/trips/new'" do
  before :each do
    user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles', role: 1, first_name: 'josh', last_name: 'mcbeth', address: '1111 tommy ln')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
  it 'can create a new trip by filling in required fields' do
    station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
    station_2 = Station.create(name: 'Test 2', dock_count: 25, city: 'Chicago', installation_date: Date.new(2017, 11, 11))

    duration = 480
    start_date = Date.new(2014, 1, 1)
    end_date = Date.new(2014, 1, 1)
    start_station_id = station_1.id
    end_station_id = station_2.id
    bike_id = 12
    subscription_type = 'Customer'
    zip_code = 60447

    visit new_admin_trip_path

    fill_in :trip_duration, with: duration
    fill_in :trip_start_date, with: start_date
    fill_in :trip_end_date, with: end_date
    select station_1.name, from: :trip_start_station_id
    select station_2.name, from: :trip_end_station_id
    fill_in :trip_bike_id, with: bike_id
    fill_in :trip_zip_code, with: zip_code
    click_on 'Create Trip'

    expect(current_path).to eq(trip_path(Trip.last))
    expect(page).to have_content('Successfully created trip')
  end
  it 'cannot create a new trip without filling in required fields' do
    station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
    station_2 = Station.create(name: 'Test 2', dock_count: 25, city: 'Chicago', installation_date: Date.new(2017, 11, 11))

    duration = 480
    start_date = Date.new(2014, 1, 1)
    end_date = Date.new(2014, 1, 1)
    start_station_id = station_1.id
    end_station_id = station_2.id
    bike_id = 12
    subscription_type = 'Customer'
    zip_code = 60447

    visit new_admin_trip_path

    fill_in :trip_duration, with: nil
    fill_in :trip_start_date, with: start_date
    fill_in :trip_end_date, with: end_date
    select station_1.name, from: :trip_start_station_id
    select station_2.name, from: :trip_end_station_id
    fill_in :trip_bike_id, with: bike_id
    fill_in :trip_zip_code, with: zip_code
    click_on 'Create Trip'

    expect(current_path).to eq(new_admin_trip_path)
    expect(page).to have_content('Trip not created. Try again.')
  end
end
