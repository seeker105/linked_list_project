gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
# require 'minitest'
require 'pry'
require_relative 'jungle_beat'

class JungleBeatTest < Minitest::Test

  def test_an_empty_list_can_be_created
    list = JungleBeat.new
    assert_equal nil, list.head
  end

  def test_is_a_new_list_with_no_data_empty?
    list = JungleBeat.new
    assert list.empty?
  end

  def test_does_an_empty_list_include_anything?
    list = JungleBeat.new
    refute list.include?("beep")

  end

  def test_a_list_can_be_created_with_data
    list = JungleBeat.new("bop deep boop dop clap clop")
    assert_equal 6, list.count
  end

  def test_append_a_single_item
    list = JungleBeat.new
    list.append("bop")
    assert_equal "bop", list.head.value
  end

  def test_append_multiple_items
    list = JungleBeat.new
    list.append("bop deep boop clop")
    assert_equal "bop deep boop clop", list.all

    list = JungleBeat.new
    list.append("bop")
    list.append("deep")
    list.append("boop")
    list.append("clop")
    assert_equal "bop deep boop clop", list.all
    assert_equal 4, list.count
  end

  def test_append_returns_the_number_of_items_added
    list = JungleBeat.new
    item_count = list.append("bop")
    assert_equal 1, item_count

    item_count_2 = list.append("bop deep boop dop")
    assert_equal 4, item_count_2
    assert_equal 5, list.count
  end

  def test_count_1_item
    list = JungleBeat.new
    list.append("bop")
    assert list.count == 1
  end

  def test_count_3_items
    list = JungleBeat.new
    list.append("bop")
    list.append("beep")
    list.append("doop")
    assert_equal 3, list.count
  end

  def test_play
    list = JungleBeat.new
    list.append("bop")
    list.append("beep")
    list.append("doop")
    assert_equal 3, list.play
  end

  def test_data_can_be_retrieved_by_index
    list = JungleBeat.new("bop deep boop dop")
    assert_equal "bop", list.find(0,1)
    assert_equal "deep", list.find(1,1)
    assert_equal "boop", list.find(2,1)
    assert_equal "dop", list.find(3,1)

    assert_equal "deep boop", list.find(1,2)
    assert_equal "deep boop dop", list.find(1,3)
    end

  def test_all_returns_all_values_in_a_string
    list = JungleBeat.new("bop deep boop dop")
    assert_equal "bop deep boop dop", list.all

    list.append("ding dah ooh")
    assert_equal "bop deep boop dop ding dah ooh", list.all
  end

  def test_prepend_inserts_the_values_at_the_start
    list = JungleBeat.new
    list.prepend("beep")
    assert_equal "beep", list.all
    list.prepend("dop bop")
    assert_equal "dop bop beep", list.all
    list.prepend("pa ooh dah")
    assert_equal "pa ooh dah dop bop beep", list.all
  end

  def test_prepend_returns_the_number_of_items_prepended
    list = JungleBeat.new
    item_count = list.prepend("dop bop")
    assert_equal 2, item_count

    item_count = list.prepend("pa ooh na")
    assert_equal 3, item_count
  end

  def test_insert_a_single_item_at_index_0_in_an_empty_list
    list = JungleBeat.new
    item_count = list.insert(0, "dop")
    assert_equal 1, item_count
    assert_equal "dop", list.all
  end

  def test_insert_a_single_item_at_index_in_a_non_empty_list
    # skip
    list = JungleBeat.new("dop bop whoop doop")
    list.insert(1, "tee")
    assert_equal "dop tee bop whoop doop", list.all
  end

  def test_insert_multiple_items_at_index_in_a_non_empty_list
    # skip
    list = JungleBeat.new("dop bop whoop doop")
    list.insert(1, "tee tah")
    assert_equal "dop tee tah bop whoop doop", list.all
  end

  def test_insert_a_single_item_beyond_the_end_of_the_list
    # skip
    list = JungleBeat.new("dop bop whoop doop")
    assert_equal nil, list.insert(10, "tee")
    assert_equal 4,list.count
    assert_equal "dop bop whoop doop", list.all
  end

  def test_insert_multiple_items_beyond_the_end_of_the_list
    # skip
    list = JungleBeat.new("dop bop whoop doop")
    assert_equal nil, list.insert(10, "tee rah dop")
    assert_equal 4,list.count
    assert_equal "dop bop whoop doop", list.all
  end

  def test_return_a_single_item_at_a_given_index
    list = JungleBeat.new("dop bop whoop doop")
    assert_equal "whoop", list.find(2,1)
  end

  def test_return_multiple_items_starting_at_a_given_index
    list = JungleBeat.new("dop bop whoop doop ooh na sa ding")
    assert_equal "doop ooh na sa", list.find(3,4)
  end

  def test_include_returns_true_if_the_data_was_found
    list = JungleBeat.new
    list.prepend("dop bop")
    assert list.include?("dop")

    refute list.include?("ooh")
    list.append("pa ooh na")
    assert list.include?("ooh")

    list.insert(1, "la")
    assert list.include?("la")
  end

  def test_a_single_pop_removes_the_last_node_and_returns_its_value
    list = JungleBeat.new
    list.prepend("dop bop beep")
    list.append("pa ooh na")
    list_element = list.pop(1)
    assert_equal "na", list_element
    list_element = list.pop(1)
    assert_equal "ooh", list_element
    list_element = list.pop(1)
    assert_equal "pa", list_element
    list_element = list.pop(1)
    assert_equal "beep", list_element
    list_element = list.pop(1)
    assert_equal "bop", list_element
    list_element = list.pop(1)
    assert_equal "dop", list_element
    list_element = list.pop(1)
    assert_equal nil, list_element
    list_element = list.pop(1)
    assert_equal nil, list_element
    list_element = list.pop(1)
    assert_equal nil, list_element
  end

  def test_multiple_pops_remove_the_last_nodes_and_returns_their_values
    list = JungleBeat.new
    list.prepend("dop bop beep")
    list.append("pa ooh na")
    list_element = list.pop(2)
    assert_equal "ooh na", list_element
    list_element = list.pop(3)
    assert_equal "bop beep pa", list_element

    list = JungleBeat.new("pa ooh dah dop bop beep dop tee bop whoop doop")
    list_element = list.pop(4)
    assert_equal "tee bop whoop doop", list_element

    list = JungleBeat.new("pa ooh dah dop bop beep dop tee bop whoop doop")
    list_element = list.pop(11)
    assert_equal "pa ooh dah dop bop beep dop tee bop whoop doop", list_element
  end

  def test_pop_beyond_the_end_of_the_array
    list = JungleBeat.new
    list.prepend("dop bop beep")
    list.append("pa ooh na")
    list_element = list.pop(2)
    assert_equal "ooh na", list_element
    list_element = list.pop(3)
    assert_equal "bop beep pa", list_element
    list_element = list.pop(4)
    assert_equal "dop", list_element

    list = JungleBeat.new("pa ooh dah dop bop beep dop tee bop whoop doop")
    list_element = list.pop(20)
    assert_equal "pa ooh dah dop bop beep dop tee bop whoop doop", list_element
  end

  def test_pop_from_an_empty_array
    list = JungleBeat.new
    list_element = list.pop(1)
    assert_equal nil, list_element
    list_element = list.pop(6)
    assert_equal nil, list_element
    list_element = list.pop(7)
    assert_equal nil, list_element
  end

  def test_it_rejects_words_not_in_the_sounds_list_as_bad_input
    list = JungleBeat.new
    list.append("dop")
    assert_equal 0, list.append("Mississippi")
    assert_equal "dop", list.all
    assert_equal 3, list.prepend("tee tee tee Mississippi")
    assert_equal "tee tee tee dop", list.all
  end
end
