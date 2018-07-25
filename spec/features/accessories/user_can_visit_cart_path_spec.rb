require 'rails_helper'

describe 'when user visits /cart' do
  before(:each) do
    @user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles')
    @accessory1 = Accessory.create!(title: 'title1', description: 'desc1', price: 11.00)
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
    @accessory12 = Accessory.create!(title: 'title12', description: 'desc1', price: 10.00)

    visit bike_shop_path

    within(".accessory-#{@accessory1.id}") do
      click_button "Add to Cart"
    end

    within(".accessory-#{@accessory12.id}") do
      click_button "Add to Cart"
    end

    within(".accessory-#{@accessory12.id}") do
      click_button "Add to Cart"
    end


  end
  it 'see all bike accessories i have added to my cart' do
    visit cart_path
    subtotal12 = (@accessory12.price * 2)
    subtotal1 = @accessory1.price
    grand_total = subtotal12 + subtotal1
    expect(page).to have_content(@accessory12.title)
    expect(page).to have_content("$#{@accessory12.price}")
    expect(page).to have_content(@accessory1.title)
    expect(page).to have_content("$#{@accessory1.price}")
    expect(page).to have_xpath("//img[@src='#{@accessory12.image}']")
    expect(page).to have_content("Subtotal: $#{subtotal12}")
    expect(page).to have_content("Subtotal: $#{subtotal1}")
    expect(page).to have_content("Grand Total: $#{grand_total}")
  end
  it 'see accessories when logged in' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit cart_path
    subtotal12 = (@accessory12.price * 2)
    subtotal1 = @accessory1.price
    grand_total = subtotal12 + subtotal1
    expect(page).to have_content(@accessory12.title)
    expect(page).to have_content("$#{@accessory12.price}")
    expect(page).to have_content(@accessory1.title)
    expect(page).to have_content("$#{@accessory1.price}")
    expect(page).to have_xpath("//img[@src='#{@accessory12.image}']")
    expect(page).to have_content("Subtotal: $#{subtotal12}")
    expect(page).to have_content("Subtotal: $#{subtotal1}")
    expect(page).to have_content("Grand Total: $#{grand_total}")
  end
  it 'can click to remove an item from cart' do
    visit cart_path

    within(".cart-accessory-#{@accessory12.id}") do
      click_link "Remove"
    end

    expect(current_path).to eq(cart_path)

    expect(page).to have_content("Successfully removed #{@accessory12.title} from your cart.")
    expect(page).to_not have_css(".cart-accessory-#{@accessory12.id}")
    click_link "#{@accessory12.title}"

    expect(current_path).to eq(accessory_path(@accessory12))
  end
end
