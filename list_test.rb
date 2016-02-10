gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
# require 'minitest'
require 'pry'
require_relative 'list'

class ListTest < Minitest::Test

  def test_an_empty_list_can_be_created
    list = List.new
    assert_equal nil, list.head
  end

  def test_is_a_new_list_with_no_data_empty?
    list = List.new
    assert list.empty?
  end

  def test_a_list_can_be_created_with_data
    list = List.new("bop deep boop dop clap clop")
    assert_equal 6, list.count
  end

  def test_append_a_single_item
    list = List.new
    list.append("bop")
    assert_equal "bop", list.head.value
  end

  def test_append_multiple_items
    list = List.new
    list.append("bop deep boop clop")
    assert_equal "bop deep boop clop", list.all

    list = List.new
    list.append("bop")
    list.append("deep")
    list.append("boop")
    list.append("clop")
    assert_equal "bop deep boop clop", list.all
    assert_equal 4, list.count
  end

  def test_count_1_item
    list = List.new
    list.append("bop")
    assert list.count == 1
  end

  def test_count_3_items
    list = List.new
    list.append("bop")
    list.append("beep")
    list.append("doop")
    assert_equal 3, list.count
  end

  def test_append_returns_the_number_of_items_added
    list = List.new
    item_count = list.append("bop")
    assert_equal 1, item_count

    item_count_2 = list.append("bop deep boop dop")
    assert_equal 4, item_count_2
    assert_equal 5, list.count
  end

  def test_data_can_be_retrieved_by_index
    list = List.new("bop deep boop dop")
    assert_equal "bop", list.find(0,1)
    assert_equal "deep", list.find(1,1)
    assert_equal "boop", list.find(2,1)
    assert_equal "dop", list.find(3,1)

    assert_equal "deep boop", list.find(1,2)
    end

  def test_all_returns_all_values_in_a_string
    list = List.new("bop deep boop dop")
    assert_equal "bop deep boop dop", list.all

    list.append("frank tom henry")
    assert_equal "bop deep boop dop frank tom henry", list.all
  end

  def test_prepend_inserts_the_values_at_the_start
    list = List.new
    list.prepend("dop bop")
    assert_equal "dop bop", list.all

    list.prepend("john henry")
    assert_equal "john henry dop bop", list.all
  end

  def test_prepend_returns_the_number_of_items_prepended
    list = List.new
    item_count = list.prepend("dop bop")
    assert_equal 2, item_count

    item_count = list.prepend("john henry smith")
    assert_equal 3, item_count
  end

  def test_insert_a_single_item_at_index_in_a_non_empty_list
    list = List.new("dop bop whoop doop")
    list.insert(1, "fred")
    assert_equal "dop fred bop whoop doop", list.all
  end

  def test_insert_multiple_items_at_index_in_a_non_empty_list
    list = List.new("dop bop whoop doop")
    list.insert(1, "fred jones")
    assert_equal "dop fred jones bop whoop doop", list.all
  end

  def test_return_the_item_at_a_given_index
    list = List.new("dop bop whoop doop")
    assert_equal "whoop", list.find(2,1)
  end

  def test_return_multiple_items_starting_at_a_given_index
    list = List.new("dop bop whoop doop henry smith susie frank")
    assert_equal "doop henry smith susie", list.find(3,4)
  end

  def test_include_returns_true_if_the_data_was_found
    list = List.new
    list.prepend("dop bop")
    assert list.include?("dop")

    refute list.include?("henry")
    list.append("john henry smith")
    assert list.include?("henry")

    list.insert(1, "whosat")
    assert list.include?("whosat")
  end

end
