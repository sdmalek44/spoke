require 'rails_helper'

describe 'user visits trip show page' do
  it 'can see all of that trips attributes' do
    station1 = Station.create!(name: 'name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
    station2 = Station.create!(name: 'eman', dock_count: 30, city: 'ytic', installation_date: Date.new(2013, 2, 15))
    trip = Trip.create!(duration: 44, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 5), start_station_id: station1.id, end_station_id: station2.id, bike_id: 3, subscription_type: 1, zip_code: 68686)

    visit trip_path(trip)

    expect(page).to have_content(trip.duration)
    expect(page).to have_content(trip.start_date)
    expect(page).to have_content(station1.name)
    expect(page).to have_content(trip.start_date)
    expect(page).to have_content(station2.name)
    expect(page).to have_content(trip.bike_id)
    expect(page).to have_content(trip.subscription_type)
    expect(page).to have_content(trip.zip_code)
  end
end
