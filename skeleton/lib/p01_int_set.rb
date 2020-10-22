class MaxIntSet
  attr_reader :store

  def initialize(max)
    @store = Array.new(max,false)
  end

  def insert(num)
    validate!(num)
    return false if self.include?(num)
    store[num] = true 
  end

  def remove(num)
    validate!(num)
    return nil if !self.include?(num)
    store[num] = false 
  end

  def include?(num)
    validate!(num)
    store[num] 
  end

  private

  def is_valid?(num)
    num.between?(0, store.length - 1)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
    # is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    # return false if self.include?(num) #only insert item that is not in the set
    self[num] << num if !self.include?(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count
  attr_accessor :store 
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return false if self.include?(num)
    self[num] << num 
    @count += 1
    resize! if count > num_buckets
  end

  def remove(num)
    @count -= 1 if self[num].delete(num) #num return nil, nil is falsey valu
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_arr = @store.dup 
    @count = 0
    @store = Array.new(num_buckets*2){ Array.new }
    new_arr.flatten.each{|num| self.insert(num)}
  end
end
