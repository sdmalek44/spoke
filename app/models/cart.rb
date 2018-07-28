class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
  end

  def add_accessory(id)
    @contents[id.to_s] ||= 0
    @contents[id.to_s] += 1
    @contents
  end

  def total_count
    @contents.values.sum
  end

  def count_of(id)
    @contents[id.to_s].to_i
  end

  def make_accessories
    Accessory.where(id: @contents.keys)
  end

  def subtotal(accessory)
    @contents[accessory.id.to_s] * accessory.price
  end

  def grand_total(all_accessories)
    byebug
    all_accessories.inject(0) do |sum, accessory|
       sum += @contents[accessory.id.to_s] * accessory.price
    end
  end

  def remove_accessory(id)
    @contents.delete(id.to_s)
    @contents
  end

  def decrease_quantity(id)
    @contents[id.to_s] -= 1 if @contents[id.to_s] > 0
    remove_accessory(id) if @contents[id.to_s] <= 0
    @contents
  end

end
