require 'rails_helper'

describe "A user visits '/bike-shop'" do
  describe 'as a visitor' do
    it 'they see all accessories and their information' do
      accessory_1 = Accessory.create(title: 'Horn', description: 'Let people know you are on a bike', price: 12.50)
      accessory_2 = Accessory.create(title: 'Water Bottle', description: 'Stay hydrated', price: 8.50)

      visit bike_shop_path

      expect(page).to have_content(accessory_1.title)
      expect(page).to have_content(accessory_1.description)
      expect(page).to have_content("Price: $#{accessory_1.price}")
      expect(page).to have_content(accessory_2.title)
      expect(page).to have_content(accessory_2.description)
      expect(page).to have_content("Price: $#{accessory_2.price}")
    end
    it 'they see a button to add items to cart' do
      accessory_1 = Accessory.create(title: 'Horn', description: 'Let people know you are on a bike', price: 12.50)

      visit bike_shop_path

      expect(page).to have_button 'Add to Cart'
    end
    it 'they cannot add retired items to cart' do
      accessory_1 = Accessory.create(title: 'Horn', description: 'Let people know you are on a bike', price: 12.50, retired?: true)

      visit bike_shop_path

      expect(page).to have_button('Accessory Retired', disabled: true)
      expect(page).to_not have_button 'Add to Cart'
    end
  end

  describe "an admin user visits 'admin/bike-shop" do
    before :each do
      user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles', role: 1, first_name: 'josh', last_name: 'mcbeth', address: '1111 tommy ln')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end
    it 'they see same information as a regular visitor' do
      accessory_1 = Accessory.create(title: 'Horn', description: 'Let people know you are on a bike', price: 12.50)
      accessory_2 = Accessory.create(title: 'Water Bottle', description: 'Stay hydrated', price: 8.50, retired?: true)

      visit admin_bike_shop_path

      expect(page).to have_content(accessory_1.title)
      expect(page).to have_content(accessory_1.description)
      expect(page).to have_content("Price: $#{accessory_1.price}")
      expect(page).to have_content("Status: Active")
      expect(page).to have_content(accessory_2.title)
      expect(page).to have_content(accessory_2.description)
      expect(page).to have_content("Price: $#{accessory_2.price}")
      expect(page).to have_content("Status: Retired")
    end
    it 'they can go to an edit page for an accessory' do
      accessory_1 = Accessory.create(title: 'Horn', description: 'Let people know you are on a bike', price: 12.50)

      visit admin_bike_shop_path

      click_on 'Edit'

      expect(current_path).to eq(edit_admin_accessory_path(accessory_1))
    end
    it 'they can retire an active accessory from the admin bike-shop' do
      accessory_1 = Accessory.create!(title: 'Horn', description: 'Let people know you are on a bike', price: 12.50)

      visit admin_bike_shop_path

      expect(page).to have_content('Status: Active')

      click_button 'Retire'

      expect(current_path).to eq(admin_bike_shop_path)
      expect(page).to have_content("Successfully retired #{accessory_1.title}")
      expect(page).to have_content('Status: Retired')
    end
    it 'they can activate a retired accessory from the admin bike-shop' do
      accessory_1 = Accessory.create!(title: 'Horn', description: 'Let people know you are on a bike', price: 12.50, retired?: true)

      visit admin_bike_shop_path

      expect(page).to have_content('Status: Retired')

      click_button 'Activate'

      expect(current_path).to eq(admin_bike_shop_path)
      expect(page).to have_content("Successfully activated #{accessory_1.title}")
      expect(page).to have_content('Status: Active')
    end
  end
end
