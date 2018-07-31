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

Accessory.create(title: 'Bike Horn', description: 'Beep beep', price: 15.00, image: 'https://images.homedepot-static.com/productImages/1f222671-76c2-499f-98df-35d2779d2b0b/svn/ventura-bike-parts-accessories-201463-64_1000.jpg')
Accessory.create(title: 'Helmet', description: 'Head Protection', price: 25.00, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRspQNa1YDP3WB8hPfxv6uDRkekX4v6JBzBhLZqjYVGBfwcRUhQ')
Accessory.create(title: 'T-Shirt', description: 'S, M, or L', price: 20.00, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjyuRfP3WyPCl0R3UuH99EqLxstlRAFK-cozWvIg6BTMS_fB__Vg')
Accessory.create(title: 'Bumper Sticker', description: 'Sticks to your car', price: 5.00, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNZrFZW3oEmzM6knUDmhHlS0R79951C3tAinjgnnHpeMHIXYt4bA')
Accessory.create(title: 'Fridge Magnet', description: 'Sticks to your fridge', price: 5.00, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqizkflEO9BRIkhzZCv8XS8B_5I0lk4-YcQV9yS6WCA5IJpahnKA')
Accessory.create(title: 'Sunscreen', description: "Don't Get Burnt!", price: 5.00, retired?: true, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTpiLBngTTiadydmZ99BnSTy8I5VcThbAyw44kVZq_ZmXMma0Miw')
Accessory.create(title: 'Map', description: 'Never get lost again!', price: 6.00, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRS7Arei-ZS7Oo6ZIZXvyCHmbaPBz0CSvDZUkebp1PrIJiA2FJ')
Accessory.create(title: 'Sweatshirt', description: 'Keep warm, comes in S, M, or L', price: 35.00, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBBOfSsfonoe-Z49tSClbk8iosFpdjNF4YLG_526pZsAJGB1hnmg')
Accessory.create(title: 'Spoke', description: 'Keep your tires strong and sturdy', price: 3.00, retired?: true, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLW_0LeP20vImhiiANdauczmBCuJqY7jvoXW5uod731Ey884r1')
Accessory.create(title: 'Umbrella', description: 'Stay dry out there!', price: 8.00, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgSiD2qKEqdX_p_LcZYtQyEch_eyG_013VI2Q0DG75FvVHGH96')
Accessory.create(title: 'Ball Cap', description: 'One size fits all', price: 18.00, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXMOVr1NozygjItBLlRsGwhXvUP1thfhGMTWSEc0qfqGm8EfA8')
Accessory.create(title: 'Sunglasses', description: 'Keep the sun out of your eyes', price: 10.00, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8h9YNqxulX5VYM8LNQfwWcn5aJAQx1MVLea1tOLdEGf-PDyxb')
Accessory.create(title: 'Shoes', description: 'They go on your feet', price: 25.00, retired?: true, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQW7--GD6UeB2VJ9y6Cbo6OuKQsQs0QFO9xqUXJDjiSU2ilgsve')
Accessory.create(title: 'Water Bottle', description: 'To stay hydrated', price: 12.00, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvBZBr4qIjnjNw4LP4PdMl8x9yaIkL_ib8vVR_1PMItiXZ34oi')
Accessory.create(title: 'Fanny Pack', description: "It's like a backpack for your fanny", price: 15.00, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTO8wf4ZQUIYdowP40jlu9ADWcSYdkQQmTpdOfv8X7UfaxD_Zn2')
Accessory.create(title: 'Postcard', description: 'Write home to your friends', price: 1.00, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLkSmoPl7lNg7CaWvX6yxF6Rd-HdqISNT3XPR_tnqDWJEHlpGv6A')
Accessory.create(title: 'Dog Leash', description: 'For walking your dog', price: 10.00, retired?: true, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHwzzwqEeYhGCL7kqcJh9jmd0VZqPNqKYQTV1BTN5-jnxKBkQv6g')
Accessory.create(title: 'Picture Frame', description: 'Display your favorite photos', price: 7.00, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_uYKuLp3F4xKmU5KmleY2FWh3ndwndvwJUxdCJKT4ZdD13wRr8A')
Accessory.create(title: 'Bike Seat', description: 'Stay comfortable on long bike rides', price: 30.00, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLMkOraVFygr5TmI9C-cgIw-SZXTXyyko6lNg7kDz7ML0tOWfd')
Accessory.create(title: 'Flashlight', description: 'For late night rides', price: 15.00, retired?: true, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRM_YEf4UX8R1wO7c0quxgBSUoubOn_mUdLXMlhfIo0lbFxFSPU')

user = User.create(username: 'happyharry', email: 'email@email.email', password: 'turtles', first_name: 'hare', last_name: 'margret', address: '1234 dolly st.')
User.create(username: 'stephen', email: 'stephen@email.email', password: 'stephen', role: 1, first_name: 'Billy', last_name: 'Bob', address: '132 Oak St')
accessory1 = Accessory.create(title: 'Hat', description: 'It goes on your head', price: 10.00, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4YJTMrRtgaQzU1W-mKbCoRRUsdDnEE6TeODS04rHosZDfxQch')
accessory2 = Accessory.create(title: 'Whistle', description: "Let everyone know you're riding a bike", price: 20.00, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJBBUoYu-QmK47AB1Goq9Z6EdkTZ9OfwraFkecYFFQPn52UxJOPA')
accessory3 = Accessory.create(title: 'Bike Chain', description: 'Extra rusty bike chain', price: 30.00, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGt_7xpa1F8a8cjjBQOr8gZXpRi08qT-2JkDZVIg6i94uvDlCCKA')

order_1 = user.orders.create(status: 3)
order_accessory1 = order_1.order_accessories.create(quantity: 5, accessory_id: accessory1.id)
order_accessory2 = order_1.order_accessories.create(quantity: 3, accessory_id: accessory2.id)

order_2 = user.orders.create(status: 1)
order_2.order_accessories.create(quantity: 2, accessory_id: accessory2.id)
order_2.order_accessories.create(quantity: 3, accessory_id: accessory3.id)

order_3 = user.orders.create(status: 0)
order_3.order_accessories.create(quantity: 4, accessory_id: accessory1.id)
order_3.order_accessories.create(quantity: 4, accessory_id: accessory3.id)

order_4 = user.orders.create(status: 2)
order_4.order_accessories.create(quantity: 2, accessory_id: accessory1.id)
order_4.order_accessories.create(quantity: 4, accessory_id: accessory3.id)

order_5 = user.orders.create(status: 2)
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
