require 'rails_helper'

describe 'when admin user visits /dashboard' do
  before(:each) do
    @user = User.create!(username: 'bob', email: 'bob@email.email', password: 'bob', role: 1, first_name: 'billy', last_name: 'bobthorton', address: '5555 billybob st')
    @admin = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles', first_name: 'hare', last_name: 'margret', address: '1234 dolly st.', role: 1)
    @accessory1 = Accessory.create!(title: 'title1', description: 'desc1', price: 10.00)
    @accessory2 = Accessory.create!(title: 'title2', description: 'desc2', price: 20.00)
    @accessory3 = Accessory.create!(title: 'title3', description: 'desc3', price: 30.00)

    @order_1 = @user.orders.create!(status: 'Completed')
    @order_accessory1 = @order_1.order_accessories.create!(quantity: 5, accessory_id: @accessory1.id)
    @order_accessory2 = @order_1.order_accessories.create!(quantity: 3, accessory_id: @accessory2.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

  end
  it 'can see an orders attributes' do
    visit order_path(@order_1)

    expect(page).to have_content(@order_1.created_at.strftime('%m/%d/%Y'))
    expect(page).to have_content(@user.first_name.titleize)
    expect(page).to have_content(@user.last_name.titleize)
    expect(page).to have_content(@user.address.titleize)
  end
end
