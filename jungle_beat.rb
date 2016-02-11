require_relative 'node'

class JungleBeat

  attr_accessor :head, :rate, :voice

  def initialize(data=nil)
    @default_rate = 500
    @default_voice = "Boing"
    @rate = @default_rate
    @voice = @default_voice
    if data == nil
      @head = nil
    else
      append(data)
    end
  end

  def vailidate_data(data)
    data_array = data.split
    valid_sounds = ["ding", "dah", "la", "na", "pa", "bop", "deep", "boop",
                    "dop", "clap", "clop", "doop", "ooh", "whoop", "tee",
                    "tah", "sa", "beep", "rah"]
    result_array = []
    data_array.each do |sound|
      if valid_sounds.include?(sound)
        result_array << sound
      end
    end
    if result_array.length == 0
      return 0
    else
      return result_array
    end
  end

  def empty?
    @head == nil
  end

  def prepend(data)
    #check for valid data and return 0 if data invalid
    data_array = vailidate_data(data)
    if data_array == 0
      return data_array
    end
    data_array.reverse.each do |value|
      new_node = Node.new(value)
      new_node.pointer = @head
      @head = new_node
    end
    return data_array.length
  end

  def append(data)
    #check for valid data and return 0 if data invalid
    data_array = vailidate_data(data)
    if data_array == 0
      return data_array
    end
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
    #head and tail are the same.
    #Append each new item.
    data_array.each do |value|
      new_node = Node.new(value)
      temp.pointer = new_node
      temp = new_node
    end
    return element_count
  end

  def insert(index, data)
    #if the array is empty and the index is zero append at the beginning
    if empty?
      @head = Node.new(data)
      return 1
    end
    #if the index is beyond the last element return nil
    if index+1 > count
      return nil
    end
    data_array = vailidate_data(data)
    if data_array == 0
      return data_array
    end
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
    #at this point current_element should hold the element at the start index
    #begin constructing the return string
    index_counter = 1
    output_string = current_element.value
    while current_element != nil and index_counter < number_of_items
      current_element = current_element.pointer
      output_string += " " + current_element.value
      index_counter += 1
    end
    return output_string
  end

    def pop(number_of_items=0)
      #if number_of_items requested is 0 or less return empty string
      if number_of_items <= 0
        return ""
      end
      #if list is empty return nil
      if empty?
        return nil
      end
      #if it's a single element list return the head value
      if count == 1
        result_string = @head.value
        @head = nil
        return result_string
      end
      #if number_of_items to return is greater than or equal to the length of
      #the list return the entire list
      if number_of_items >= count
        return all
      end
      #if it's not an empty list, start by finding the element before the ones
      #to be popped
      last_element = @head
      index_counter = 0
      while index_counter < (count - (number_of_items + 1))
        last_element = last_element.pointer
        index_counter += 1
      end

      #now last_element holds the element before the ones to be popped
      result_string = ""
      temp = last_element.pointer
      result_string = temp.value
      while temp.pointer != nil
        temp = temp.pointer
        result_string += " " + temp.value
      end
      last_element.pointer = nil
      return result_string
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

  def play
    if empty?
      puts "Nothing to play!"
    else
      `say -r #{@rate} -v #{@voice} #{all}`
    end
    return count
  end

  def reset_rate
    @rate = @default_rate
  end

  def reset_voice
    @voice = @default_voice
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

end
