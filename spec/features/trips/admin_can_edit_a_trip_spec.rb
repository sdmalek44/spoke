require 'rails_helper'

describe "Admin user visits '/admin/trips/:id/edit'" do
  before :each do
    user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles', role: 1, first_name: 'josh', last_name: 'mcbeth', address: '1111 tommy ln')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
  it 'can edit a trip by filling in required fields' do
    station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
    station_2 = Station.create(name: 'Test 2', dock_count: 25, city: 'Chicago', installation_date: Date.new(2017, 11, 11))
    trip = Trip.create!(duration: 44, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 5), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 3, subscription_type: 1, zip_code: 68686)

    editted_duration = 480
    editted_start_date = Date.new(2014, 1, 1)
    editted_end_date = Date.new(2014, 1, 1)
    editted_start_station_id = station_2.id
    editted_end_station_id = station_1.id
    editted_bike_id = 12
    editted_subscription_type = 0
    editted_zip_code = 60447

    visit edit_admin_trip_path(trip)

    fill_in :trip_duration, with: editted_duration
    fill_in :trip_start_date, with: editted_start_date
    fill_in :trip_end_date, with: editted_end_date
    select editted_start_station_id, from: :trip_start_station_id
    select editted_end_station_id, from: :trip_end_station_id
    fill_in :trip_bike_id, with: editted_bike_id
    fill_in :trip_zip_code, with: editted_zip_code
    click_on 'Update Trip'

    expect(current_path).to eq(trip_path(trip))
    expect(page).to have_content('Successfully updated trip')
    expect(page).to have_content("Duration: #{editted_duration}")
    expect(page).to have_content("Start Date: #{editted_start_date.strftime("%m/%d/%Y")}")
    expect(page).to have_content("End Date: #{editted_end_date.strftime("%m/%d/%Y")}")
    expect(page).to have_content("Start Station: #{station_2.name}")
    expect(page).to have_content("End Station: #{station_1.name}")
    expect(page).to have_content("Bike ID: #{editted_bike_id}")
    expect(page).to have_content("Zip Code: #{editted_zip_code}")
  end
  it 'cannot create a new trip without filling in required fields' do
    station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
    station_2 = Station.create(name: 'Test 2', dock_count: 25, city: 'Chicago', installation_date: Date.new(2017, 11, 11))
    trip = Trip.create!(duration: 44, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 5), start_station_id: station_1.id, end_station_id: station_2.id, bike_id: 3, subscription_type: 1, zip_code: 68686)

    duration = 480
    start_date = Date.new(2014, 1, 1)
    end_date = Date.new(2014, 1, 1)
    start_station_id = station_1.id
    end_station_id = station_2.id
    bike_id = 12
    subscription_type = 'Customer'
    zip_code = 60447

    visit edit_admin_trip_path(trip)

    fill_in :trip_duration, with: nil
    fill_in :trip_start_date, with: start_date
    fill_in :trip_end_date, with: end_date
    select station_1.name, from: :trip_start_station_id
    select station_2.name, from: :trip_end_station_id
    fill_in :trip_bike_id, with: bike_id
    fill_in :trip_zip_code, with: zip_code
    click_on 'Update Trip'

    expect(current_path).to eq(edit_admin_trip_path(trip))
    expect(page).to have_content('Trip was not updated. Try again.')
  end
end
