require 'rails_helper'

describe 'when user visits /bike-shop' do
  it 'can see at least 12 bike accessories (items) for sale' do
    accessory1 = Accessory.create!(title: 'title1', description: 'desc1', price: 23.33)
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
    accessory12 = Accessory.create!(title: 'title12', description: 'desc1', price: 23.33)

    visit bike_shop_path

    expect(page).to have_content(accessory1.title)
    expect(page).to have_content(accessory12.title)
  end
end
