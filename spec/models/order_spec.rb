require 'rails_helper'

describe Order, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :user_id}
  end
  describe 'relationships' do
    it {should have_many :accessories}
    it {should have_many :order_accessories}
    it {should belong_to :user}
  end
  describe 'instance methods' do
    it 'can create order accessories given cart hash' do
      @user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles')
      @accessory1 = Accessory.create!(title: 'title1', description: 'desc1', price: 10.00)
      @accessory2 = Accessory.create!(title: 'title2', description: 'desc2', price: 20.00)
      @order_1 = @user.orders.create!(status: 'Completed')

      @order_1.create_order_accessories({"#{@accessory1.id}" => 2, "#{@accessory2.id}" => 1})
      expect(OrderAccessory.count).to eq(2)
    end
    it 'can get grand total of everything in order' do
      @user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles')
      @accessory1 = Accessory.create!(title: 'title1', description: 'desc1', price: 10.00)
      @accessory2 = Accessory.create!(title: 'title2', description: 'desc2', price: 20.00)
      @order_1 = @user.orders.create!(status: 'Completed')

      @order_1.create_order_accessories({"#{@accessory1.id}" => 2, "#{@accessory2.id}" => 1})
      expect(@order_1.grand_total).to eq(40.0)
    end
  end
  describe 'class methods' do
    it 'can get total number of orders in each status' do
      @user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles')
      @order_1 = @user.orders.create!(status: 'Completed')
      @order_2 = @user.orders.create!(status: 'Ordered')
      @order_3 = @user.orders.create!(status: 'Ordered')
      @order_4 = @user.orders.create!(status: 'Cancelled')
      @order_5 = @user.orders.create!(status: 'Paid')

      expect(Order.orders_per_status).to eq({'Completed' => 1, 'Ordered' => 2,
                                             'Cancelled' => 1, 'Paid' => 1})
    end
  end
end
