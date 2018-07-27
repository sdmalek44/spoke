require 'rails_helper'

describe 'when registered user visits /dashboard' do
  before(:each) do
    @user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles')
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
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end
  it 'can see all orders attributed to that user' do
    visit dashboard_path

    expect(page).to have_content("Order Id: #{@order_1.id}")
    expect(page).to have_content("Order Id: #{@order_2.id}")
    expect(page).to have_content("Order Id: #{@order_3.id}")
  end
  it 'can click on an order and go to that order show page' do
    visit dashboard_path

    click_link "Order Id: #{@order_1.id}"

    expect(current_path).to eq(order_path(@order_1))
    expect(page).to have_content("Grand Total: $#{@order_1.grand_total}")
    expect(page).to have_content(@order_1.status + " On: " + @order_1.created_at.strftime('%m/%d/%Y'))
    expect(page).to have_link(@accessory1.title)

    expect(page).to have_content("Quantity: #{@order_accessory1.quantity}")
    expect(page).to have_content("Subtotal: $#{@order_accessory1.subtotal}")
    expect(page).to have_link(@accessory2.title)
    expect(page).to have_content("Quantity: #{@order_accessory2.quantity}")
    expect(page).to have_content("Subtotal: $#{@order_accessory2.subtotal}")
  end

end
