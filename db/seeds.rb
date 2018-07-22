# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'CSV'

station_data = CSV.open('./db/csv/station.csv', headers: true, header_converters: :symbol)
station_data.each do |station|
  Station.create!(
    id: station[:id],
    name: station[:name],
    dock_count: station[:dock_count],
    city: station[:city],
    installation_date: Date.strptime(station[:installation_date], "%m/%d/%Y")
  )
end

puts "Seeded #{Station.count} stations."
puts "Installation Date: #{Station.last.installation_date}"
