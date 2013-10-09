require './test/test_helper'

class FakeCommandRunner

  def load(filename)
    "running load with #{filename}"
  end

  def queue_print(order)
    if order
      "running queue print ordered by #{order}"
    else
      "running queue print for all items in queue"
    end
  end

  def queue_save_to(filename)
    "running queue save to queue_file.csv"
  end

  def queue_count
    "running queue count"
  end

  def queue_clear
    "running queue clear"
  end

  def help
    "running help for available commands"
  end

  def help_commands(command)
    "running help for the #{command} command"
  end

  def find_first_name(attribute)
    "running find by first_name for #{attribute}"
  end

  def find_last_name(attribute)
    "running find by last_name for #{attribute}"
  end

  def find_email(attribute)
    "running find by email for #{attribute}"
  end

  def find_zipcode(attribute)
    "running find by zipcode for #{attribute}"
  end

  def find_city(attribute)
    "running find by city for #{attribute}"
  end

  def find_state(attribute)
    "running find by state for #{attribute}"
  end

  def find_address(attribute)
    "running find by address for #{attribute}"
  end

  def find_home_phone(attribute)
    "running find by home_phone for #{attribute}"
  end

end


class CommandInterpreterTest < Minitest::Test
  attr_reader :ci

  def setup
    @ci = CommandInterpreter.new(FakeCommandRunner)
  end

  def test_it_exists
    assert CommandInterpreter
  end

  def test_it_accepts_a_load_instruction
    command = "load some_data.csv"
    result  = ci.run(command)
    assert_equal "running load with some_data.csv", result
  end

  def test_it_accepts_a_load_without_a_filename
    result = ci.run("load")
    assert_equal "running load with event_attendees.csv", result
  end

  def test_it_prints_ordered_by_the_last_name
    result = ci.run("queue print by last_name")
    assert_equal "running queue print ordered by last_name", result
  end

  def test_it_prints_with_no_order_specified
    result = ci.run("queue print")
    assert_equal "running queue print for all items in queue", result
  end

  def test_it_counts_the_queue
    result = ci.run("queue count")
    assert_equal "running queue count", result
  end

  def test_it_clears_the_queue
    result = ci.run("queue clear")
    assert_equal "running queue clear", result
  end

  def test_it_saves_the_queue_to_a_file
    result = ci.run("queue save to queue_file.csv")
    assert_equal "running queue save to queue_file.csv", result
  end

  def test_it_accepts_a_help_without_a_command
    result = ci.run("help")
    assert_equal "running help for available commands", result
  end

  def test_it_accepts_a_help_instruction
    command = "help queue count"
    result  = ci.run(command)
    assert_equal "running help for the queue count command", result
  end

  def test_it_accepts_a_find_first_name_command_and_criteria
    result = ci.run("find first_name Sam")
    assert_equal "running find by first_name for Sam", result
  end

  def test_it_accepts_a_find_last_name_and_criteria
    result = ci.run("find last_name Johnson")
    assert_equal "running find by last_name for Johnson", result
  end

  def test_it_accepts_a_find_email_and_criteria
    result = ci.run("find email sam@example.com")
    assert_equal "running find by email for sam@example.com", result
  end

  def test_it_accepts_a_find_zipcode_and_criteria
    result = ci.run("find zipcode 80204")
    assert_equal "running find by zipcode for 80204", result
  end

  def test_it_accepts_a_find_city_and_criteria
    result = ci.run("find city Denver")
    assert_equal "running find by city for Denver", result
  end

  def test_it_accepts_a_find_state_and_criteria
    result = ci.run("find state CO")
    assert_equal "running find by state for CO", result
  end

  def test_it_accepts_a_find_address_and_criteria
    result = ci.run("find address 123 First Street")
    assert_equal "running find by address for 123 First Street", result
  end

  def test_it_accepts_a_find_home_phone_and_criteria
    result = ci.run("find home_phone 4257650025")
    assert_equal "running find by home_phone for 4257650025", result
  end

end


