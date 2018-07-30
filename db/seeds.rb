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
  Station.create(
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
  trip[:zip_code] = nil if trip[:zip_code] == 'nil'

  Trip.create(
    duration: trip[:duration],
    start_date: Date.strptime(trip[:start_date], "%m/%d/%Y"),
    start_station_id: trip[:start_station_id],
    end_date: Date.strptime(trip[:end_date], "%m/%d/%Y"),
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

Accessory.create(title: 'Bike Horn', description: 'Beep beep', price: 15.00)
Accessory.create(title: 'Helmet', description: 'Head Protection', price: 25.00)
Accessory.create(title: 'T-Shirt', description: 'S, M, or L', price: 20.00)
Accessory.create(title: 'Bumper Sticker', description: 'Sticks to your car', price: 5.00)
Accessory.create(title: 'Fridge Magnet', description: 'Sticks to your fridge', price: 5.00)
Accessory.create(title: 'Sunscreen', description: "Don't Get Burnt!", price: 5.00, retired?: true)
Accessory.create(title: 'Map', description: 'Never get lost again!', price: 6.00)
Accessory.create(title: 'Sweatshirt', description: 'Keep warm, comes in S, M, or L', price: 35.00)
Accessory.create(title: 'Spoke', description: 'Keep your tires strong and sturdy', price: 3.00, retired?: true)
Accessory.create(title: 'Umbrella', description: 'Stay dry out there!', price: 8.00)
Accessory.create(title: 'Ball Cap', description: 'One size fits all', price: 18.00)
Accessory.create(title: 'Sunglasses', description: 'Keep the sun out of your eyes', price: 10.00)
Accessory.create(title: 'Shoes', description: 'They go on your feet', price: 25.00, retired?: true)
Accessory.create(title: 'Water Bottle', description: 'To stay hydrated', price: 12.00)
Accessory.create(title: 'Fanny Pack', description: "It's like a backpack for your fanny", price: 15.00)
Accessory.create(title: 'Postcard', description: 'Write home to your friends', price: 1.00)
Accessory.create(title: 'Dog Leash', description: 'For walking your dog', price: 10.00, retired?: true)
Accessory.create(title: 'Picture Frame', description: 'Display your favorite photos', price: 7.00)
Accessory.create(title: 'Bike Seat', description: 'Stay comfortable on long bike rides', price: 30.00)
Accessory.create(title: 'Flashlight', description: 'For late night rides', price: 15.00, retired?: true)

user = User.create(username: 'happyharry', email: 'email@email.email', password: 'turtles', first_name: 'hare', last_name: 'margret', address: '1234 dolly st.')
User.create(username: 'stephen', email: 'stephen@email.email', password: 'stephen', role: 1, first_name: 'Billy', last_name: 'Bob', address: '132 Oak St')
accessory1 = Accessory.create(title: 'Hat', description: 'goes on head', price: 10.00)
accessory2 = Accessory.create(title: 'Whistle', description: 'you blow it', price: 20.00)
accessory3 = Accessory.create(title: 'Bike Chain', description: 'extra rusty bike chain', price: 30.00)

order_1 = user.orders.create(status: 'completed')
order_accessory1 = order_1.order_accessories.create(quantity: 5, accessory_id: accessory1.id)
order_accessory2 = order_1.order_accessories.create(quantity: 3, accessory_id: accessory2.id)

order_2 = user.orders.create(status: 'ordered')
order_2.order_accessories.create(quantity: 2, accessory_id: accessory2.id)
order_2.order_accessories.create(quantity: 3, accessory_id: accessory3.id)

order_3 = user.orders.create(status: 'cancelled')
order_3.order_accessories.create(quantity: 4, accessory_id: accessory1.id)
order_3.order_accessories.create(quantity: 4, accessory_id: accessory3.id)

order_4 = user.orders.create(status: 'paid')
order_4.order_accessories.create(quantity: 2, accessory_id: accessory1.id)
order_4.order_accessories.create(quantity: 4, accessory_id: accessory3.id)

order_5 = user.orders.create(status: 'paid')
order_5.order_accessories.create(quantity: 4, accessory_id: accessory1.id)
order_5.order_accessories.create(quantity: 6, accessory_id: accessory3.id)

puts "Seeded #{Order.count} Orders"

puts "Seeded #{OrderAccessory.count} OrderAccessories"

puts "Seeded #{Accessory.count} accessories"

User.create(username: 'admin', password: 'password', email: 'admin@email.com', role: 1, first_name: 'Admin', last_name: 'Boy', address: '123 Maple St')

puts "Created admin user (username: admin, password: password)"

User.create(username: 'default', password: 'password', email: 'default@email.com', first_name: 'Tristan', last_name: 'Smith', address: '1255 19th St')

puts 'Created default user (username: default, password: password)'

ActiveRecord::Base.connection.reset_pk_sequence!('stations')
ActiveRecord::Base.connection.reset_pk_sequence!('trips')
ActiveRecord::Base.connection.reset_pk_sequence!('conditions')
