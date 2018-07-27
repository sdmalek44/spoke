require 'rails_helper'

describe 'when admin user visits /dashboard' do
  before(:each) do
    @user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles', first_name: 'hare', last_name: 'margret', address: '1234 dolly st.')
    @admin = User.create!(username: 'bob', email: 'bob@email.email', password: 'bob', role: 1, first_name: 'billy', last_name: 'bobthorton', address: '5555 billybob st')
    @accessory1 = Accessory.create!(title: 'title1', description: 'desc1', price: 10.00)
    @accessory2 = Accessory.create!(title: 'title2', description: 'desc2', price: 20.00)
    @accessory3 = Accessory.create!(title: 'title3', description: 'desc3', price: 30.00)

    @order_1 = @user.orders.create!(status: 'ordered')
    @order_accessory1 = @order_1.order_accessories.create!(quantity: 5, accessory_id: @accessory1.id)
    @order_accessory2 = @order_1.order_accessories.create!(quantity: 3, accessory_id: @accessory2.id)

    @order_2 = @user.orders.create!(status: 'completed')
    @order_2.order_accessories.create!(quantity: 2, accessory_id: @accessory2.id)
    @order_2.order_accessories.create!(quantity: 3, accessory_id: @accessory3.id)

    @order_3 = @user.orders.create!(status: 'paid')
    @order_3.order_accessories.create!(quantity: 4, accessory_id: @accessory1.id)
    @order_3.order_accessories.create!(quantity: 4, accessory_id: @accessory3.id)

    @order_4 = @user.orders.create!(status: 'cancelled')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end
  it 'can see list of all orders' do
    visit admin_dashboard_path

    expect(page).to have_content("Order Id: #{@order_1.id}")
    expect(page).to have_content("Order Id: #{@order_2.id}")
    expect(page).to have_content("Order Id: #{@order_3.id}")
  end
  it 'can select all orders' do
    visit admin_dashboard_path

    click_on "Sort By Status"
    click_on "All"

    expect(page).to have_content("Order Id: #{@order_1.id}")
    expect(page).to have_content("Order Id: #{@order_2.id}")
    expect(page).to have_content("Order Id: #{@order_3.id}")
    expect(page).to have_content("Order Id: #{@order_4.id}")
  end
  it 'can select all orders' do
    visit admin_dashboard_path

    click_on "Sort By Status"
    click_on "Ordered"

    expect(page).to have_content("Order Id: #{@order_1.id}")
    expect(page).to_not have_content("Order Id: #{@order_2.id}")
    expect(page).to_not have_content("Order Id: #{@order_3.id}")
    expect(page).to_not have_content("Order Id: #{@order_4.id}")
  end
  it 'can select paid orders' do
    visit admin_dashboard_path

    click_on "Sort By Status"
    click_on "Paid"

    expect(page).to_not have_content("Order Id: #{@order_1.id}")
    expect(page).to_not have_content("Order Id: #{@order_2.id}")
    expect(page).to have_content("Order Id: #{@order_3.id}")
    expect(page).to_not have_content("Order Id: #{@order_4.id}")

  end
  it 'can select all orders' do
    visit admin_dashboard_path

    click_on "Sort By Status"
    click_on "Cancelled"

    expect(page).to_not have_content("Order Id: #{@order_1.id}")
    expect(page).to_not have_content("Order Id: #{@order_2.id}")
    expect(page).to_not have_content("Order Id: #{@order_3.id}")
    expect(page).to have_content("Order Id: #{@order_4.id}")
  end
  it 'can select all orders' do
    visit admin_dashboard_path

    click_on "Sort By Status"
    click_on "Completed"

    expect(page).to_not have_content("Order Id: #{@order_1.id}")
    expect(page).to_not have_content("Order Id: #{@order_3.id}")
    expect(page).to have_content("Order Id: #{@order_2.id}")
    expect(page).to_not have_content("Order Id: #{@order_4.id}")
  end
end
