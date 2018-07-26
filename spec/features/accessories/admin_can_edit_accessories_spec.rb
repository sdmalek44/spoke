require 'rails_helper'

describe "An admin user visits '/admin/bike-shop'" do
  before :each do
    user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles', role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
  it 'they see a button to edit an accessory' do
    accessory_1 = Accessory.create!(title: 'Horn', description: 'Let people know you are on a bike', price: 12.50)

    visit admin_bike_shop_path

    click_button 'Edit'

    expect(current_path).to eq(edit_admin_accessory_path(accessory_1))
  end
end
