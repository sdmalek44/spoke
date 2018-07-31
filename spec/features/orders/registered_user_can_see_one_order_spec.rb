require 'rails_helper'

describe 'when registered user visits /dashboard' do
  before(:each) do
    @user1 = User.create!(username: 'bob', email: 'bob@email.email', password: 'bob', first_name: 'billy', last_name: 'bobthorton', address: '5555 billybob st')
    @user2 = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles', first_name: 'hare', last_name: 'margret', address: '1234 dolly st.')
    @accessory1 = Accessory.create!(title: 'title1', description: 'desc1', price: 10.00)
    @accessory2 = Accessory.create!(title: 'title2', description: 'desc2', price: 20.00)
    @accessory3 = Accessory.create!(title: 'title3', description: 'desc3', price: 30.00)

    @order_1 = @user1.orders.create!(status: 3)
    @order_accessory1 = @order_1.order_accessories.create!(quantity: 5, accessory_id: @accessory1.id)
    @order_accessory2 = @order_1.order_accessories.create!(quantity: 3, accessory_id: @accessory2.id)
    @order_2 = @user2.orders.create!(status: 3)
    @order_accessory3 = @order_1.order_accessories.create!(quantity: 5, accessory_id: @accessory1.id)
    @order_accessory4 = @order_1.order_accessories.create!(quantity: 3, accessory_id: @accessory2.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
  end
  it 'can see own order' do
    visit order_path(@order_1)

    expect(page).to have_content(@order_accessory1.accessory.title)
    expect(page).to have_content("Quantity: #{@order_accessory1.quantity}")
    expect(page).to have_content("Subtotal: $#{@order_accessory1.subtotal}")
    expect(page).to have_content("Grand Total: $#{@order_1.grand_total}")
    expect(page).to have_content("Status: #{@order_1.status.titleize}")
    expect(page).to have_content("Ordered On: #{@order_1.created_at.strftime('%m/%d/%Y')}")
    expect(page).to have_content("#{@order_1.status.titleize} On: #{@order_1.updated_at.strftime('%m/%d/%Y')}")
  end
  it 'can not see another users order' do
    visit order_path(@order_2)

    expect(page).to_not have_content(@order_accessory2.accessory.title)
    expect(page).to_not have_content("Quantity: #{@order_accessory3.quantity}")
    expect(page).to_not have_content("Subtotal: $#{@order_accessory3.subtotal}")
    expect(page).to_not have_content("Grand Total: $#{@order_2.grand_total}")
    expect(page).to_not have_content("Status: #{@order_2.status.titleize}")
    expect(page).to_not have_content("Ordered On: #{@order_2.created_at.strftime('%m/%d/%Y')}")
    expect(page).to_not have_content("#{@order_2.status.titleize} On: #{@order_2.updated_at.strftime('%m/%d/%Y')}")
  end
end
