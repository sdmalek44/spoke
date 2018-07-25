require 'rails_helper'
=begin
As a registered user,
When I visit '/conditions-dashboard',
I see the Breakout of average, highest, and lowest number of rides on days with a high temperature in 10 degree chunks (e.g. average number of rides on days with high temps between fifty and sixty degrees),
I see the Breakout of average, highest, and lowest number of rides on days with precipitation in half-inch increments,
I see the Breakout of average, highest, and lowest number of rides on days with mean wind speeds in four mile increments,
I see the Breakout of average, highest, and lowest number of rides on days with mean visibility in miles in four mile increments.
=end
describe 'a registered user visits /conditions-dashboard' do
  before :each do
    @station1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
    @station2 = Station.create(name: 'Test 2', dock_count: 25, city: 'Chicago', installation_date: Date.new(2017, 11, 11))
    @condition_1 = Condition.create(date: Date.new(2017, 12, 11), max_temperature: 75.0, mean_temperature: 65.0, min_temperature: 55.0, mean_humidity: 75.0, mean_visibility: 10.0, mean_wind_speed: 11.0, precipitation: 0.23)
    @condition_2 = Condition.create(date: Date.new(2016, 11, 10), max_temperature: 70.0, mean_temperature: 60.0, min_temperature: 50.0, mean_humidity: 65.0, mean_visibility: 5.0, mean_wind_speed: 12.0, precipitation: 0.12)
    @condition_3 = Condition.create(date: Date.new(2016, 1, 1), max_temperature: 81.0, mean_temperature: 66.0, min_temperature: 51.0, mean_humidity: 65.0, mean_visibility: 5.0, mean_wind_speed: 22.0, precipitation: 1.12)
    @condition_4 = Condition.create(date: Date.new(2016, 5, 5), max_temperature: 83.0, mean_temperature: 68.0, min_temperature: 53.0, mean_humidity: 65.0, mean_visibility: 5.0, mean_wind_speed: 33.0, precipitation: 2.12)
    @trip_1 = Trip.create!(duration: 11, start_date: Date.new(2017, 12, 11), end_date: Date.new(2018, 2, 5), start_station_id: @station1.id, end_station_id: @station2.id, bike_id: 3, subscription_type: 1, zip_code: 68686)
    @trip_2 = Trip.create!(duration: 22, start_date: Date.new(2017, 12, 11), end_date: Date.new(2018, 2, 5), start_station_id: @station1.id, end_station_id: @station2.id, bike_id: 3, subscription_type: 1, zip_code: 68686)
    @trip_3 = Trip.create!(duration: 33, start_date: Date.new(2016, 11, 10), end_date: Date.new(2018, 2, 5), start_station_id: @station1.id, end_station_id: @station2.id, bike_id: 3, subscription_type: 1, zip_code: 68686)
    @trip_4 = Trip.create!(duration: 44, start_date: Date.new(2016, 11, 10), end_date: Date.new(2018, 2, 5), start_station_id: @station1.id, end_station_id: @station2.id, bike_id: 3, subscription_type: 1, zip_code: 68686)
    @trip_5 = Trip.create!(duration: 55, start_date: Date.new(2016, 1, 1), end_date: Date.new(2018, 2, 5), start_station_id: @station1.id, end_station_id: @station2.id, bike_id: 3, subscription_type: 1, zip_code: 68686)
    @trip_6 = Trip.create!(duration: 66, start_date: Date.new(2016, 1, 1), end_date: Date.new(2018, 2, 5), start_station_id: @station1.id, end_station_id: @station2.id, bike_id: 3, subscription_type: 1, zip_code: 68686)
    @trip_7 = Trip.create!(duration: 77, start_date: Date.new(2016, 1, 1), end_date: Date.new(2018, 2, 5), start_station_id: @station1.id, end_station_id: @station2.id, bike_id: 3, subscription_type: 1, zip_code: 68686)
    @trip_8 = Trip.create!(duration: 88, start_date: Date.new(2016, 5, 5), end_date: Date.new(2018, 2, 5), start_station_id: @station1.id, end_station_id: @station2.id, bike_id: 3, subscription_type: 1, zip_code: 68686)
    @trip_9 = Trip.create!(duration: 99, start_date: Date.new(2016, 5, 5), end_date: Date.new(2018, 2, 5), start_station_id: @station1.id, end_station_id: @station2.id, bike_id: 3, subscription_type: 1, zip_code: 68686)
    @trip_10 = Trip.create!(duration: 100, start_date: Date.new(2016, 5, 5), end_date: Date.new(2018, 2, 5), start_station_id: @station1.id, end_station_id: @station2.id, bike_id: 3, subscription_type: 1, zip_code: 68686)
  end
  it 'sees highest number of rides with high max temperature in 10 degree chunks' do
    visit conditions_dashboard_path

    ride_count = Trip.date_with_most_rides(70)[:rides]

    expect(page).to have_content("Highest number of rides: #{ride_count}")
  end
end
