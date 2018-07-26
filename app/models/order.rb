class Order < ApplicationRecord
  validates_presence_of :user_id
  belongs_to :user
  has_many :order_accessories
  has_many :accessories, through: :order_accessories

  def create_order_accessories(cart_contents)
    cart_contents.each do |accessory_id, quantity|
      order_accessories.create(accessory_id: accessory_id, quantity: quantity)
    end
  end

  def grand_total
    order_accessories.inject(0) do |sum, order_accesory|
      sum += (order_accesory.quantity * order_accesory.accessory.price)
    end
  end
end