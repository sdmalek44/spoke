require 'rails_helper'

describe "User visits '/accessory/:id'" do
  it 'they see the image, title, description, and price for that accessory' do
    accessory_1 = Accessory.create(title: 'Horn', description: 'Let people know you are on a bike', price: 12.50)

    visit accessory_path(accessory_1)

    expect(page).to have_content(accessory_1.title)
    expect(page).to have_content(accessory_1.description)
    expect(page).to have_content("$#{accessory_1.price}")
    expect(page).to have_link('Add to Cart')
  end
end
