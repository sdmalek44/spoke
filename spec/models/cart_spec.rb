require 'rails_helper'

RSpec.describe Cart do
  subject { Cart.new({'1' => 2, '2' => 3}) }

  describe 'instance methods' do
    it 'can add accessory' do
      subject.add_accessory(1)

      expect(subject.contents).to eq({'1' => 3, '2' => 3})
    end
    it 'can remove accessory' do
      subject.remove_accessory(1)

      expect(subject.contents).to eq({'2' => 3})
    end
    it 'can decrease quantity of accessory' do
      subject.decrease_quantity(1)

      expect(subject.contents).to eq({'1' => 1, '2' => 3})
    end
    it 'if quantity is zero it removes accessory' do
      subject.decrease_quantity(1)
      subject.decrease_quantity(1)

      expect(subject.contents).to eq({'2' => 3})
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
    it 'can create total for single item with' do
      accessory_1 = Accessory.create(title: 'Horn', description: 'Let people know you are on a bike', price: 12.50, retired?: true)
      accessory_2 = Accessory.create(title: 'Horn', description: 'Let people know you are on a bike', price: 12.50, retired?: true)

      expect(subject.subtotal(accessory_1)).to eq(25.00)
    end
    it 'calculate total for whole cart' do
      accessory_1 = Accessory.create(title: 'Horn', description: 'Let people know you are on a bike', price: 12.50, retired?: true)
      accessory_2 = Accessory.create(title: 'Horn', description: 'Let people know you are on a bike', price: 12.50, retired?: true)

      expect(subject.grand_total(Accessory.all)) .to eq(62.50)
    end
  end
end
