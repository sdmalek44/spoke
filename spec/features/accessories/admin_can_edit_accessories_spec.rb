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
  it 'they can edit an accessory by inputting valid information' do
    accessory_1 = Accessory.create!(title: 'Horn', description: 'Let people know you are on a bike', price: 12.50)

    visit edit_admin_accessory_path(accessory_1)

    editted_title = 'Editted Title'
    editted_description = 'Test Description'
    price = 100.00

    fill_in :accessory_title, with: editted_title
    fill_in :accessory_description, with: editted_description
    fill_in :accessory_price, with: price
    click_on 'Update Accessory'

    expect(current_path).to eq(accessory_path(accessory_1))
    expect(page).to have_content("Successfully updated #{editted_title}")
  end
  it 'they cannot edit an accessory without inputting valid information' do
    accessory_1 = Accessory.create!(title: 'Horn', description: 'Let people know you are on a bike', price: 12.50)

    visit edit_admin_accessory_path(accessory_1)

    editted_title = 'Editted Title'
    editted_description = 'Test Description'
    price = 100.00

    fill_in :accessory_title, with: nil
    fill_in :accessory_description, with: editted_description
    fill_in :accessory_price, with: price
    click_on 'Update Accessory'

    expect(current_path).to eq(admin_accessory_path(accessory_1))
    expect(page).to have_content("Accessory not updated. Try again.")
  end
end
