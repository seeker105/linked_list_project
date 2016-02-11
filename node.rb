class Node

  attr_accessor :value, :pointer

  def initialize(value="", pointer=nil)
    @value = value
    @pointer = pointer
  end

  def to_s
    array_representation = []
    array_representation << @value
    array_representation << @pointer
    array_representation.inspect
  end

end
