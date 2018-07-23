# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

station_data = CSV.open('./db/trim-data/station.csv', headers: true, header_converters: :symbol)
station_data.each do |station|
  Station.create!(
    id: station[:id],
    name: station[:name],
    dock_count: station[:dock_count],
    city: station[:city],
    installation_date: Date.strptime(station[:installation_date], "%m/%d/%Y")
  )
end

puts "Seeded #{Station.count} stations"

trips_data = CSV.open('./db/trim-data/trip-trim.csv', headers: true, header_converters: :symbol)
trips_data.each_with_index do |trip, index|
  sub_type = 0
  sub_type = 1 unless trip[:subscription_type].downcase == "customer"
  Trip.create(
    duration: trip[:duration],
    start_date: Time.strptime(trip[:start_date], "%m/%d/%Y %H:%M"),
    start_station_id: trip[:start_station_id],
    end_date: Time.strptime(trip[:end_date], "%m/%d/%Y %H:%M"),
    end_station_id: trip[:end_station_id],
    bike_id: trip[:bike_id],
    subscription_type: sub_type,
    zip_code: trip[:zip_code]
  )
end

puts "Seeded #{Trip.count} trips"

weather_data = CSV.open('./db/trim-data/weather-trim.csv', headers: true, header_converters: :symbol)
weather_data.each do |condition|
  Condition.create(
    date: Date.strptime(condition[:date], "%m/%d/%Y"),
    max_temperature: condition[:max_temperature_f].to_f,
    mean_temperature: condition[:mean_temperature_f].to_f,
    min_temperature: condition[:min_temperature_f].to_f,
    mean_humidity: condition[:mean_humidity].to_f,
    mean_visibility: condition[:mean_visibility_miles].to_f,
    mean_wind_speed: condition[:mean_wind_speed_mph].to_f,
    precipitation: condition[:precipitation_inches].to_f
  )
end

puts "Seeded #{Condition.count} conditions"
