require 'rails_helper'

describe 'user can go to station show page' do
  it 'can see all attributes' do
    station = Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))

    visit station_path(station)

    expect(current_path).to eq('/stations/2name')
    expect(page).to have_content(station.name)
    expect(page).to have_content(station.dock_count)
    expect(page).to have_content(station.city)
    expect(page).to have_content(station.installation_date)
  end
  it 'can see the number of rides started at this station' do
    station = Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
    Trip.create!(duration: 44, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 5), start_station_id: station.id, end_station_id: station.id, bike_id: 3, subscription_type: 1, zip_code: 68686)
    Trip.create!(duration: 44, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 5), start_station_id: station.id, end_station_id: station.id, bike_id: 3, subscription_type: 1, zip_code: 68686)

    visit station_path(station)

    expect(page).to have_content("Number of Rides Started Here: #{Trip.all.count}")
  end
  it 'can see the number of rides ended at this station' do
    station = Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
    Trip.create!(duration: 44, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 5), start_station_id: station.id, end_station_id: station.id, bike_id: 3, subscription_type: 1, zip_code: 68686)
    Trip.create!(duration: 44, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 5), start_station_id: station.id, end_station_id: station.id, bike_id: 3, subscription_type: 1, zip_code: 68686)

    visit station_path(station)

    expect(page).to have_content("Number of Rides Ended Here: #{Trip.all.count}")
  end
  it 'can see most frequent destination station for trips that started at station' do
    station1 = Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
    station2 = Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
    Trip.create!(duration: 44, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 5), start_station_id: station1.id, end_station_id: station2.id, bike_id: 3, subscription_type: 1, zip_code: 68686)
    Trip.create!(duration: 44, start_date: Date.new(2020, 2, 4), end_date: Date.new(2020, 2, 5), start_station_id: station1.id, end_station_id: station2.id, bike_id: 3, subscription_type: 1, zip_code: 68686)
    Trip.create!(duration: 44, start_date: Date.new(2030, 2, 4), end_date: Date.new(2030, 2, 5), start_station_id: station1.id, end_station_id: station1.id, bike_id: 3, subscription_type: 1, zip_code: 68686)

    visit station_path(station1)

    expect(page).to have_content("Most Popular Place to Go to From Here: #{station1.frequent_destination_station.name}")
  end
  it 'can see most frequent origination station for trips that started at station' do
    station1 = Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
    station2 = Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
    Trip.create!(duration: 44, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 5), start_station_id: station2.id, end_station_id: station1.id, bike_id: 3, subscription_type: 1, zip_code: 68686)
    Trip.create!(duration: 44, start_date: Date.new(2020, 2, 4), end_date: Date.new(2020, 2, 5), start_station_id: station2.id, end_station_id: station1.id, bike_id: 3, subscription_type: 1, zip_code: 68686)
    Trip.create!(duration: 44, start_date: Date.new(2030, 2, 4), end_date: Date.new(2030, 2, 5), start_station_id: station1.id, end_station_id: station1.id, bike_id: 3, subscription_type: 1, zip_code: 68686)

    visit station_path(station1)

    expect(station1.frequent_origination_station).to eq(station2)
    expect(page).to have_content("Most Popular Place to Come From to Here: #{station1.frequent_destination_station.name}")
  end
  it 'can calculate most frequent origination date for trips that started at station' do
    station1 = Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
    station2 = Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
    date = Date.new(2000, 2, 4)

    Trip.create!(duration: 44, start_date: date, end_date: Date.new(2000, 2, 5), start_station_id: station1.id, end_station_id: station1.id, bike_id: 3, subscription_type: 1, zip_code: 68686)
    Trip.create!(duration: 44, start_date: date, end_date: Date.new(2000, 2, 5), start_station_id: station1.id, end_station_id: station1.id, bike_id: 3, subscription_type: 1, zip_code: 68686)
    Trip.create!(duration: 44, start_date: Date.new(2010, 2, 4), end_date: Date.new(2010, 2, 5), start_station_id: station1.id, end_station_id: station1.id, bike_id: 3, subscription_type: 1, zip_code: 68686)

    visit station_path(station1)

    expect(page).to have_content("Date with the Most Trips Started Here: #{station1.date_with_most_trips.strftime('%d/%m/%Y')}")
  end
  it 'can see most frequent origination zip for trips that started at station' do
    station1 = Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
    station2 = Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
    date = Date.new(2000, 2, 4)

    Trip.create!(duration: 44, start_date: date, end_date: Date.new(2000, 2, 5), start_station_id: station1.id, end_station_id: station1.id, bike_id: 3, subscription_type: 1, zip_code: 55555)
    Trip.create!(duration: 44, start_date: date, end_date: Date.new(2000, 2, 5), start_station_id: station1.id, end_station_id: station1.id, bike_id: 3, subscription_type: 1, zip_code: 55555)
    Trip.create!(duration: 44, start_date: Date.new(2010, 2, 4), end_date: Date.new(2010, 2, 5), start_station_id: station1.id, end_station_id: station1.id, bike_id: 3, subscription_type: 1, zip_code: 44444)

    visit station_path(station1)

    expect(page).to have_content("Most Frequent Zip Code of Users Starting Here: #{station1.zip_code_with_most_trips}")
  end
  it 'can see most frequent origination zip for trips that started at station' do
    station1 = Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
    station2 = Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
    date = Date.new(2000, 2, 4)

    Trip.create!(duration: 44, start_date: date, end_date: Date.new(2000, 2, 5), start_station_id: station1.id, end_station_id: station1.id, bike_id: 3, subscription_type: 1, zip_code: 55555)
    Trip.create!(duration: 44, start_date: date, end_date: Date.new(2000, 2, 5), start_station_id: station1.id, end_station_id: station1.id, bike_id: 3, subscription_type: 1, zip_code: 55555)
    Trip.create!(duration: 44, start_date: Date.new(2010, 2, 4), end_date: Date.new(2010, 2, 5), start_station_id: station1.id, end_station_id: station1.id, bike_id: 2, subscription_type: 1, zip_code: 44444)

    visit station_path(station1)

    expect(page).to have_content("Bike Id Starting Here Most Frequently: #{station1.bike_id_with_most_trips}")
  end
end
