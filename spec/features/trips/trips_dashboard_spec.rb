require 'rails_helper'

describe "A registered user visits 'trip-dashboard'" do
  before :each do
    user = User.create(username: 'test123', email: 'email@gmail.com', password: '1234')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    @station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
    @station_2 = Station.create(name: 'Test 2', dock_count: 25, city: 'Chicago', installation_date: Date.new(2017, 11, 11))
    @station_3 = Station.create(name: 'Test 3', dock_count: 30, city: 'Chicago', installation_date: Date.new(2017, 11, 11))
    @station_4 = Station.create(name: 'Test 4', dock_count: 35, city: 'Chicago', installation_date: Date.new(2017, 11, 11))

    @trip_1 = Trip.create!(duration: 60, start_date: Date.new(2001, 1, 1), end_date: Date.new(2001, 1, 1), start_station_id: @station_1.id, end_station_id: @station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)
    @trip_2 = Trip.create!(duration: 120, start_date: Date.new(2002, 2, 2), end_date: Date.new(2002, 2, 2), start_station_id: @station_1.id, end_station_id: @station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)
    @trip_3 = Trip.create!(duration: 180, start_date: Date.new(2002, 2, 2), end_date: Date.new(2002, 2, 2), start_station_id: @station_1.id, end_station_id: @station_2.id, bike_id: 1, subscription_type: 0, zip_code: 68686)
    @trip_4 = Trip.create!(duration: 240, start_date: Date.new(2002, 2, 2), end_date: Date.new(2002, 2, 2), start_station_id: @station_2.id, end_station_id: @station_1.id, bike_id: 1, subscription_type: 1, zip_code: 68686)
    @trip_5 = Trip.create!(duration: 300, start_date: Date.new(2003, 3, 3), end_date: Date.new(2003, 3, 3), start_station_id: @station_2.id, end_station_id: @station_1.id, bike_id: 2, subscription_type: 1, zip_code: 68686)
    @trip_6 = Trip.create!(duration: 360, start_date: Date.new(2003, 3, 3), end_date: Date.new(2003, 3, 3), start_station_id: @station_3.id, end_station_id: @station_4.id, bike_id: 2, subscription_type: 1, zip_code: 68686)
    @trip_7 = Trip.create!(duration: 420, start_date: Date.new(2003, 3, 3), end_date: Date.new(2003, 3, 3), start_station_id: @station_3.id, end_station_id: @station_4.id, bike_id: 2, subscription_type: 1, zip_code: 68686)
    @trip_8 = Trip.create!(duration: 480, start_date: Date.new(2003, 3, 3), end_date: Date.new(2003, 3, 3), start_station_id: @station_4.id, end_station_id: @station_3.id, bike_id: 3, subscription_type: 1, zip_code: 68686)

    @condition_1 = Condition.create!(date: Date.new(2001, 1, 1), max_temperature: 75.0, mean_temperature: 65.0, min_temperature: 55.0, mean_humidity: 75.0, mean_visibility: 10.0, mean_wind_speed: 11.0, precipitation: 0.23)
    @condition_2 = Condition.create!(date: Date.new(2002, 2, 2), max_temperature: 70.0, mean_temperature: 60.0, min_temperature: 50.0, mean_humidity: 65.0, mean_visibility: 5.0, mean_wind_speed: 12.0, precipitation: 0.12)
    @condition_3 = Condition.create!(date: Date.new(2003, 3, 3), max_temperature: 77.0, mean_temperature: 66.0, min_temperature: 51.0, mean_humidity: 65.0, mean_visibility: 5.0, mean_wind_speed: 22.0, precipitation: 1.12)
  end

  it 'they see information about ride durations' do
    visit trips_dashboard_path

    expect(page).to have_content("Average Ride Duration: 4 minutes")
    expect(page).to have_content("Longest Ride Duration: 8 minutes")
    expect(page).to have_content("Shortest Ride Duration: 1 minutes")
  end

  it 'they see information about stations where most rides started and ended' do
    visit trips_dashboard_path

    expect(page).to have_content("Station Where Most Rides Start: #{@station_1.name}")
    expect(page).to have_content("Station Where Most Rides End: #{@station_2.name}")
  end

  it 'they see month by month breakdown of number of rides' do
    visit trips_dashboard_path

    expect(page).to have_content('January 2001 Rides: 1')
    expect(page).to have_content('February 2002 Rides: 3')
    expect(page).to have_content('March 2003 Rides: 4')
  end

  it 'they see year by year breakdown of number of rides' do
    visit trips_dashboard_path

    expect(page).to have_content('Rides in 2001: 1')
    expect(page).to have_content('Rides in 2002: 3')
    expect(page).to have_content('Rides in 2003: 4')
  end

  it 'they see most and least ridden bikes' do
    visit trips_dashboard_path

    within '.most-ridden-bike' do
      expect(page).to have_content("Id: 1")
      expect(page).to have_content("Rides: 4")
    end

    within '.least-ridden-bike' do
      expect(page).to have_content("Id: 3")
      expect(page).to have_content("Rides: 1")
    end
  end

  it 'they see information about user subscription types' do
    visit trips_dashboard_path

    expect(page).to have_content("Subscription Type: Customer, Count: 3")
    expect(page).to have_content("Subscription Type: Subscriber, Count: 5")
    expect(page).to have_content("Percentage of Total Trips: 37.5%")
    expect(page).to have_content("Percentage of Total Trips: 62.5%")
  end

  it 'they see information about the dates with the mostest and fewest rides' do
    visit trips_dashboard_path

    within '.most-rides-by-date' do
      expect(page).to have_content("Date With Most Rides: 03/03/2003")
      expect(page).to have_content("Ride Count: 4")
    end

    within '.least-rides-by-date' do
      expect(page).to have_content("Date With Fewest Rides: 01/01/2001")
      expect(page).to have_content("Ride Count: 1")
    end
  end

  it 'they see information about the weather on the day with the most rides' do
    visit trips_dashboard_path

    within '.most-rides-by-date' do
      expect(page).to have_content("Max Temperature: #{@condition_3.max_temperature} ºF")
      expect(page).to have_content("Mean Temperature: #{@condition_3.mean_temperature} ºF")
      expect(page).to have_content("Min Temperature: #{@condition_3.min_temperature} ºF")
      expect(page).to have_content("Mean Humidity: #{@condition_3.mean_humidity}%")
      expect(page).to have_content("Mean Visibility: #{@condition_3.mean_visibility} miles")
      expect(page).to have_content("Mean Wind Speed: #{@condition_3.mean_wind_speed} mph")
      expect(page).to have_content("Precipitation: #{@condition_3.precipitation} \"")
    end
  end

  it 'they see information abouth the weather on the day with the most rides' do
    visit trips_dashboard_path

    within '.least-rides-by-date' do
      expect(page).to have_content("Max Temperature: #{@condition_1.max_temperature} ºF")
      expect(page).to have_content("Mean Temperature: #{@condition_1.mean_temperature} ºF")
      expect(page).to have_content("Min Temperature: #{@condition_1.min_temperature} ºF")
      expect(page).to have_content("Mean Humidity: #{@condition_1.mean_humidity}%")
      expect(page).to have_content("Mean Visibility: #{@condition_1.mean_visibility} miles")
      expect(page).to have_content("Mean Wind Speed: #{@condition_1.mean_wind_speed} mph")
      expect(page).to have_content("Precipitation: #{@condition_1.precipitation} \"")
    end
  end
end
