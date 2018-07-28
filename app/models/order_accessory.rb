class OrderAccessory < ApplicationRecord
  validates_presence_of :quantity
  belongs_to :order
  belongs_to :accessory

  def subtotal
    accessory.price * quantity
  end
end
