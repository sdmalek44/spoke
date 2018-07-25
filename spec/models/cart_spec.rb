require 'rails_helper'

RSpec.describe Cart do
  subject { Cart.new({'1' => 2, '2' => 3}) }

  describe 'instance methods' do
    it 'can add accessory' do
      subject.add_accessory(1)

      expect(subject.contents).to eq({'1' => 3, '2' => 3})
    end
    it 'can get total accesories' do
      expect(subject.total_count).to eq(5)
    end
    it 'can get total of specific accessory' do
      expect(subject.count_of(2)).to eq(3)
    end
    it 'can make accessories from contents' do
      accessory_1 = Accessory.create(title: 'Horn', description: 'Let people know you are on a bike', price: 12.50, retired?: true)
      accessory_2 = Accessory.create(title: 'Horn', description: 'Let people know you are on a bike', price: 12.50, retired?: true)

      expect(subject.make_accessories).to eq([accessory_1, accessory_2])
    end
  end
end
