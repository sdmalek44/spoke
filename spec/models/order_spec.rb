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
end
