require_relative 'node'

class List

  attr_accessor :head

  def initialize(data=nil)
    if data == nil
      @head = nil
    else
      append(data)
    end
    return @head
  end

  def empty?
    @head == nil
  end

  def insert(index, data)
    #if the index is beyond the last element return nil
    if index+1 > count
      return nil
    end

    data_array = data.split

    #advance down the list until the index is reached
    position = 0
    current_element = @head
    while (current_element != nil) & (position < (index-1))
      position += 1
      current_element = current_element.pointer
    end

    #at this point current_element should hold the element before the start index
    data_array.reverse.each do |value|
      new_node = Node.new(value)
      new_node.pointer = current_element.pointer
      current_element.pointer = new_node
    end
    return data_array.length
  end

  def find(index, number_of_items=1)
    #if the index is beyond the last element return nil
    if index+1 > count
      return nil
    end

    #advance down the list until the index is reached
    position = 0
    current_element = @head
    while (current_element != nil) & (position < index)
      position += 1
      current_element = current_element.pointer
    end

    def include?(value)
      current_element = @head
      while current_element != nil
        if current_element.value == value
          return true
        else
          current_element = current_element.pointer
        end
      end

      #if it exits the loop without returning true it was not found
      return false
    end

    #at this point current_element should hold the element at the start index
    #begin constructing the return string
    element_counter = 1
    output_string = current_element.value
    while current_element != nil and element_counter < number_of_items
      current_element = current_element.pointer
      output_string += " " + current_element.value
      element_counter += 1
    end
    return output_string
  end

  def prepend(data)
    data_array = data.split
    data_array.reverse.each do |value|
      new_node = Node.new(value)
      new_node.pointer = @head
      @head = new_node
    end
    return data_array.length
  end

  def count
    count = 0
    current_element = @head
    while current_element != nil
      count += 1
      current_element = current_element.pointer
    end
    return count
  end

  def all
    if @head == nil
      return ""
    else
      output_string = @head.value
      new_node = @head.pointer
      while new_node != nil
        output_string += " " + new_node.value
        new_node = new_node.pointer
      end
    end
    return output_string
  end

  def append(data)
    if data == "" || data == nil
      return 0
    end

    data_array = data.split
    element_count = data_array.length

    #if head == nil it is an empty list so append the values starting at the head
    if @head == nil
      @head = Node.new(data_array[0])
      temp = @head
      data_array.shift  #remove the element that went into the head

    #if it's not an empty list, start by finding the tail
    else
      temp = @head
      while temp.pointer != nil
        temp = temp.pointer
      end
    end

    #at this point temp points to the tail, even if it's a one element array meaning
    #head and tail are the same. If there's no more data in the array it the
    #each method should exit immediately (empty array)
    data_array.each do |value|
      new_node = Node.new(value)
      temp.pointer = new_node
      temp = new_node
    end
    return element_count
  end


end
