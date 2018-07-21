require 'rails_helper'

describe Accessory, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :description}
    it {should validate_presence_of :price}
  end
end
