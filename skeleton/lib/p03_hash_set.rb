class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return false if self.include?(key)
    self[key.hash] << key
    @count += 1
    resize! if count > num_buckets
  end

  def include?(key)
    self[key.hash].include?(key)
  end

  def remove(key)
    @count -= 1 if self[key.hash].delete(key) 
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
