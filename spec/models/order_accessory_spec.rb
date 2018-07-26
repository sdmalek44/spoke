require 'rails_helper'

describe OrderAccessory, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :quantity}
  end
  describe 'relationships' do
    it {should belong_to :accessory}
    it {should belong_to :order}
  end
end
