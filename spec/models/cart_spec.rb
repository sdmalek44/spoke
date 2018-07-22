require 'rails_helper'

RSpec.describe Cart do
  subject { Cart.new({1 => 2, 2 => 3}) }

  describe 'instance methods' do
    it 'can add accessory' do
      subject.add_accessory(1)

      expect(subject.contents).to eq({1 => 3, 2 => 3})
    end
    it 'can get total accesories' do
      expect(subject.total_count).to eq(5)
    end
  end
end
