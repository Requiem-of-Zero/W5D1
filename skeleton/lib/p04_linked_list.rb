class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    if self.prev != nil
      self.prev.next = self.next
    end
    if self.next != nil
      self.next.prev = self.prev
    end
    self.next = nil
    self.prev = nil
  end
end

class LinkedList
  include Enumerable

  attr_reader :head, :tail

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next if !empty?
  end

  def last
    @tail.prev if !empty?
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each do |node|
      if node.key == key 
        return node.val
      end
    end
    nil
  end

  def include?(key)
  end

  def append(key, val)
    new_node = Node.new(key, val) #  prev <- tail -> next

    self.tail.prev.next = new_node
    #set the new node 
    new_node.prev = tail.prev
    new_node.next = tail

    tail.prev = new_node
  end

  def update(key, val)
    self.each do |node|
      if node.key == key
        node.val = val 
        return node.val
      end
    end
  end

  def remove(key) #GG
    self.each do |node|
      if node.key == key
        node.remove
    end
  end

  def each
    curr_node = self.head.next
    until curr_node == self.tail
      yield curr_node
      curr_node = curr_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
