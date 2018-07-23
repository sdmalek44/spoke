require 'rails_helper'

describe 'when user visits /bike-shop' do
  before(:each) do
    user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles')
    @accessory1 = Accessory.create!(title: 'title1', description: 'desc1', price: 23.33)
    accessory2 = Accessory.create!(title: 'title2', description: 'desc1', price: 23.33)
    accessory3 = Accessory.create!(title: 'title3', description: 'desc1', price: 23.33)
    accessory4 = Accessory.create!(title: 'title4', description: 'desc1', price: 23.33)
    accessory5 = Accessory.create!(title: 'title5', description: 'desc1', price: 23.33)
    accessory6 = Accessory.create!(title: 'title6', description: 'desc1', price: 23.33)
    accessory7 = Accessory.create!(title: 'title7', description: 'desc1', price: 23.33)
    accessory8 = Accessory.create!(title: 'title8', description: 'desc1', price: 23.33)
    accessory9 = Accessory.create!(title: 'title9', description: 'desc1', price: 23.33)
    accessory10 = Accessory.create!(title: 'title10', description: 'desc1', price: 23.33)
    accessory11 = Accessory.create!(title: 'title11', description: 'desc1', price: 23.33)
    @accessory12 = Accessory.create!(title: 'title12', description: 'desc1', price: 23.33)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
  it 'can see at least 12 bike accessories (items) for sale' do
    visit bike_shop_path

    expect(page).to have_content(@accessory1.title)
    expect(page).to have_content(@accessory12.title)
    within(".accessory-#{@accessory1.id}") do
      expect(page).to have_button("Add to Cart")
    end
  end
  it 'can click add to cart and see a flash message that ive added to cart' do
    visit bike_shop_path
    within(".accessory-#{@accessory1.id}") do
      click_button "Add to Cart"
    end
    within(".accessory-#{@accessory12.id}") do
      click_button "Add to Cart"
    end

    expect(page).to have_content("You now have 1 #{@accessory12.title} in your cart.")
    expect(page).to have_content("Cart Count: 2")
  end
end
