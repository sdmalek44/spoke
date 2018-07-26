require 'rails_helper'

describe "An admin user visits '/admin/bike-shop/new'" do
  before :each do
    user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles', role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
  it 'they can create a new accessory by inputting valid information' do
    visit admin_bike_shop_path

    title = 'Test Accessory'
    description = "It's testable!"
    price = 15.0

    

  end
end
