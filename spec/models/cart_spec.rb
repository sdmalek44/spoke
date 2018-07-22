require 'rails_helper'

RSpec.describe Cart do
  subject { Cart.new({1 => 2, 2 => 3}) }

  describe 'instance methods' do
    it 'can add accessory' do
      subject.add_accessory(1)

      expect(subject.contents).to eq({1 => 3, 2 => 3})
    end
  end
end
