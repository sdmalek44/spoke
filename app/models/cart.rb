class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
  end

  def add_accessory(id)
    contents[id] = 0 unless contents[id]
    contents[id] += 1
  end

  def total_count
    contents.values.sum
  end

  def count_of(id)
    contents[id].to_i
  end
end
