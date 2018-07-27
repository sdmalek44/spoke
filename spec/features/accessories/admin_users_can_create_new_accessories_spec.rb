require 'rails_helper'

describe "An admin user visits '/admin/bike-shop/new'" do
  before :each do
    user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles', role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
  it 'they can create a new accessory by inputting valid information' do
    title = 'Test Accessory'
    description = "It's testable!"
    price = 15.0

    visit admin_bike_shop_new_path

    fill_in :accessory_title, with: title
    fill_in :accessory_description, with: description
    fill_in :accessory_price, with: price
    click_on 'Create Accessory'

    expect(current_path).to eq(accessory_path(Accessory.last))
    expect(page).to have_content("Successfully created #{title}")
    expect(page).to have_content(title)
    expect(page).to have_content(description)
    expect(page).to have_content("Price: $15.00")
    expect(page).to have_link('Add to Cart')
    expect(Accessory.last.image).to eq('https://www.hsjaa.com/images/joomlart/demo/default.jpg')
  end

  it 'renders same page with flash notice if incorrect input' do
    title = ''
    description = "It's testable!"
    price = 15.0

    visit admin_bike_shop_new_path

    fill_in :accessory_description, with: description
    fill_in :accessory_price, with: price
    click_on 'Create Accessory'

    expect(current_path).to eq(admin_accessories_path)
    expect(page).to have_content("Accessory not created. Try again.")
  end
end
