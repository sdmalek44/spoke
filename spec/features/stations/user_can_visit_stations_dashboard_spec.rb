require 'rails_helper'

describe 'when you visit /stations-dashboard' do
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
    Station.create!(name: '2name', dock_count: 3, city: 'city', installation_date: Date.new(2017, 3, 10))

    visit stations_dashboard_path

    expect(page).to have_content("Most Bikes Per Station: #{Station.most_bikes_per_station}")
  end
  it 'see most bikes per stations' do
    Station.create!(name: '2name', dock_count: 1, city: 'city', installation_date: Date.new(2017, 3, 10))
    station = Station.create!(name: '2name', dock_count: 3, city: 'city', installation_date: Date.new(2017, 3, 10))

    visit stations_dashboard_path

    expect(page).to have_content("Station With Most Bikes: #{Station.station_with_most_bikes.name}")
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
end
