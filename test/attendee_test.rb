require './test/test_helper'

class FormattingPhoneAndZipcodeTest < Minitest::Test 

  def test_a_3_digit_zipcode_is_invalid
    attendee = [ 
      Attendee.new(zipcode: "342")
    ]

    assert_equal 1, attendee.count
    assert_equal "00000", attendee.first.zipcode
  end

  def test_a_4_digit_zipcode_adds_a_0_at_the_beginning
    attendee = [ 
      Attendee.new(zipcode: "1234")
    ]

    assert_equal 1, attendee.count
    assert_equal "01234", attendee.first.zipcode
  end

  def test_a_9_digit_number_is_invalid
    attendee = [
      Attendee.new(home_phone: "123456789")
    ]

    assert_equal 1, attendee.count
    assert_equal "(000) 000-0000", attendee.first.home_phone
  end

  def test_a_11_digit_number_is_invalid
    attendee = [
      Attendee.new(home_phone: "01234567890")
    ]

    assert_equal 1, attendee.count
    assert_equal "(000) 000-0000", attendee.first.home_phone
  end

  def test_a_north_american_number_is_valid_with_the_prefix
    attendee = [
      Attendee.new(home_phone: "11234567890")
    ]

    assert_equal 1, attendee.count
    assert_equal "(123) 456-7890", attendee.first.home_phone
  end

  def test_numbers_get_cleaned_up
    # skip
    # phone_number = PhoneNumber.new('x234a/b567%.=89   \t00x   xx')
    # assert_equal '2345678900', phone_number.digits
    # # assert_equal '(234) 567-8900', phone_number.to_s
    attendee = [
      Attendee.new(home_phone: "11234567890")
    ]

    assert_equal 1, attendee.count
    assert_equal "(123) 456-7890", attendee.first.home_phone
  end

end

