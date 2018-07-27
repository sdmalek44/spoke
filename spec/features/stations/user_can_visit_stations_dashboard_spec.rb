require 'rails_helper'

describe 'when you visit /stations-dashboard' do
  before :each do
    @user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles', first_name: 'hare', last_name: 'margret', address: '1234 dolly st.')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'see total count of stations' do
    Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
    Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))

    visit stations_dashboard_path

    expect(page).to have_content("Total Station Count: #{Station.count}")
  end
  it 'see average_bikes_per_station' do
    Station.create!(name: '2name', dock_count: 1, city: 'city', installation_date: Date.new(2017, 3, 10))
    Station.create!(name: '2name', dock_count: 3, city: 'city', installation_date: Date.new(2017, 3, 10))

    visit stations_dashboard_path

    expect(page).to have_content("Average Bikes Per Station: #{Station.average_bikes_per_station}")
  end
  it 'see most bikes per stations' do
    Station.create!(name: '2name', dock_count: 1, city: 'city', installation_date: Date.new(2017, 3, 10))
    station = Station.create!(name: '2name', dock_count: 3, city: 'city', installation_date: Date.new(2017, 3, 10))

    visit stations_dashboard_path

    expect(page).to have_content("Most Bikes Per Station: #{station.dock_count}")
  end
  it 'see most bikes per stations' do
    Station.create!(name: '2name', dock_count: 1, city: 'city', installation_date: Date.new(2017, 3, 10))
    station = Station.create!(name: '2name', dock_count: 3, city: 'city', installation_date: Date.new(2017, 3, 10))

    visit stations_dashboard_path

    expect(page).to have_content("Station With Most Bikes: #{station.name}")
  end
  it 'see least bikes per stations' do
    station = Station.create!(name: '2name', dock_count: 1, city: 'city', installation_date: Date.new(2017, 3, 10))
    Station.create!(name: '2name', dock_count: 3, city: 'city', installation_date: Date.new(2017, 3, 10))

    visit stations_dashboard_path

    expect(page).to have_content("Least Bikes Per Station: #{station.dock_count}")
  end
  it 'see station with least bikes' do
    Station.create!(name: '2name', dock_count: 1, city: 'city', installation_date: Date.new(2017, 3, 10))
    station = Station.create!(name: '2name', dock_count: 3, city: 'city', installation_date: Date.new(2017, 3, 10))

    visit stations_dashboard_path

    expect(page).to have_content("Station With Least Bikes: #{station.name}")
  end
  it 'can see most recently installed station' do
    station1 = Station.create!(name: '1name', dock_count: 1, city: 'city1', installation_date: Date.new(2015, 3, 10))
    station2 = Station.create!(name: '2name', dock_count: 3, city: 'city2', installation_date: Date.new(2017, 3, 10))

    visit stations_dashboard_path

    expect(page).to have_content("Newest Station: #{station2.name}")
  end
  it 'can see oldest station' do
    station1 = Station.create!(name: '1name', dock_count: 1, city: 'city1', installation_date: Date.new(2015, 1, 10))
    station2 = Station.create!(name: '2name', dock_count: 3, city: 'city2', installation_date: Date.new(2017, 3, 10))

    visit stations_dashboard_path

    expect(page).to have_content("Oldest Station: #{station1.name}")
  end
end
