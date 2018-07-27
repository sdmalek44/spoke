require 'rails_helper'

describe 'when registered user visits /dashboard' do
  before(:each) do
    @user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles', first_name: 'hare', last_name: 'margret', address: '1234 dolly st.')
    @accessory1 = Accessory.create!(title: 'title1', description: 'desc1', price: 10.00)
    @accessory2 = Accessory.create!(title: 'title2', description: 'desc2', price: 20.00)
    @accessory3 = Accessory.create!(title: 'title3', description: 'desc3', price: 30.00)

    @order_1 = @user.orders.create!(status: 'Completed')
    @order_accessory1 = @order_1.order_accessories.create!(quantity: 5, accessory_id: @accessory1.id)
    @order_accessory2 = @order_1.order_accessories.create!(quantity: 3, accessory_id: @accessory2.id)
  end
  it 'can see an orders attributes' do
    visit order_path(@order_1)

    expect(page).to have_content(@order_1.created_at.strftime('%m/%d/%Y'))
  end
end
