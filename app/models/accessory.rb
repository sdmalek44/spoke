class Accessory < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates_presence_of :description
  validates_presence_of :price
  has_many :order_accessories
  has_many :orders, through: :order_accessories
end
