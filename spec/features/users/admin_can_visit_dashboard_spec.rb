require 'rails_helper'

describe 'when admin user visits /dashboard' do
  before(:each) do
    @user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles')
    @admin = User.create!(username: 'bob', email: 'bob@email.email', password: 'bob', role: 1)
    @accessory1 = Accessory.create!(title: 'title1', description: 'desc1', price: 10.00)
    @accessory2 = Accessory.create!(title: 'title2', description: 'desc2', price: 20.00)
    @accessory3 = Accessory.create!(title: 'title3', description: 'desc3', price: 30.00)

    @order_1 = @user.orders.create!(status: 'Completed')
    @order_accessory1 = @order_1.order_accessories.create!(quantity: 5, accessory_id: @accessory1.id)
    @order_accessory2 = @order_1.order_accessories.create!(quantity: 3, accessory_id: @accessory2.id)

    @order_2 = @user.orders.create!(status: 'completed')
    @order_2.order_accessories.create!(quantity: 2, accessory_id: @accessory2.id)
    @order_2.order_accessories.create!(quantity: 3, accessory_id: @accessory3.id)

    @order_3 = @user.orders.create!(status: 'canceled')
    @order_3.order_accessories.create!(quantity: 4, accessory_id: @accessory1.id)
    @order_3.order_accessories.create!(quantity: 4, accessory_id: @accessory3.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end
  it 'can see list of all orders' do
    visit admin_dashboard_path

    expect(page).to have_content("Order Id: #{@order_1.id}")
    expect(page).to have_content("Order Id: #{@order_2.id}")
    expect(page).to have_content("Order Id: #{@order_3.id}")
  end
  it 'they can click a link to go to the admin bike-shop' do
    visit admin_dashboard_path

    click_link 'Admin Bike Shop'

    expect(current_path).to eq(admin_bike_shop_path)
  end
end
