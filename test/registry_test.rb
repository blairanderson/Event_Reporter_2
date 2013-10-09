require './test/test_helper'

class RegistryTest < Minitest::Test
  attr_reader :registry

  def setup
    @registry = Registry.new
  end

  def test_it_exists
    assert Registry
  end

  def test_it_finds_attendees_by_first_name_irrespective_of_case
    registry.attendees = [
      Attendee.new(first_name: "SaRaH"),
      Attendee.new(first_name: "SaraH"),
      Attendee.new(first_name: "Billy"),
    ]

    attendees = registry.find_all_by_first_name("Sarah")

    assert_equal 2, attendees.count
    attendees.each do |attendee|
      assert_equal "sarah", attendee.first_name.downcase
    end
  end

  def test_it_finds_attendees_by_last_name_irrespective_of_case
    registry.attendees = [
      Attendee.new(last_name: "John"),
      Attendee.new(last_name: "joHn"),
      Attendee.new(last_name: "Johnson")
    ]

    attendees = registry.find_all_by_last_name("John")

    assert_equal 2, attendees.count
    attendees.each do |attendee|
      assert_equal "john", attendee.last_name.downcase
    end
  end

  def test_it_finds_attendees_by_homephone_irrespective_of_format
    registry.attendees = [
      Attendee.new(home_phone: "615.438.5000"),
      Attendee.new(home_phone: "414-520-5000"),
      Attendee.new(home_phone: "(941) 979-2000")
    ]

    attendees = registry.find_all_by_home_phone("6154385000")

    assert_equal 1, attendees.count
    attendees.each do |attendee|
      assert_equal "6154385000", attendee.home_phone
    end
  end

  def test_it_finds_attendees_by_street_irrespective_of_case
    registry.attendees = [
      Attendee.new(street: "3155 19th St NW"),
      Attendee.new(street: "2022 15th Street NW"),
      Attendee.new(street: "2022 15th Street NW"),
      Attendee.new(street: "1133 Shelton Ave")
    ]

    attendees = registry.find_all_by_street("2022 15tH StreEt NW")

    assert_equal 2, attendees.count
    attendees.each do |attendee|
      assert_equal "2022 15th street nw", attendee.street.downcase
    end
  end

  def test_it_finds_attendees_by_city_irrespective_of_case
    registry.attendees = [
      Attendee.new(city: "wAshIngTon"),
      Attendee.new(city: "WASHINGTON"),
      Attendee.new(city: "Dener")
    ]

    attendees = registry.find_all_by_city("Washington")

    assert_equal 2, attendees.count
    attendees.each do |attendee|
      assert_equal "washington", attendee.city.downcase
    end
  end

  def test_it_finds_attendees_by_state_irrespective_of_case
    registry.attendees = [
      Attendee.new(state: "HI"),
      Attendee.new(state: "hI"),
      Attendee.new(state: "CO")
    ]

    attendees = registry.find_all_by_state("HI")

    assert_equal 2, attendees.count
    attendees.each do |attendee|
      assert_equal "hi", attendee.state.downcase
    end
  end

  def test_it_finds_attendees_by_zipcode # irrespective_of_format
    registry.attendees = [
      Attendee.new(zipcode: "20009"),
      Attendee.new(zipcode: "20010"),
      Attendee.new(zipcode: "20010")
    ]

    attendees = registry.find_all_by_zipcode("20010")

    assert_equal 2, attendees.count
    attendees.each do |attendee|
      assert_equal "20010", attendee.zipcode
    end
  end

end
