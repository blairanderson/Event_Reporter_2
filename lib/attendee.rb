class Attendee
  attr_accessor :first_name,
                :last_name,
                :email,
                :home_phone,
                :street,
                :city,
                :state,
                :zipcode

  def initialize(data)
    @first_name = data[:first_name]
    @last_name  = data[:last_name]
    @email      = data[:email]
    @home_phone = clean_home_phone_number(data[:home_phone])
    @street     = data[:street]
    @city       = data[:city]
    @state      = data[:state]
    @zipcode    = clean_zipcode(data[:zipcode])
  end

  def clean_zipcode(zipcode)
    if zipcode.to_s.length <= 3
        "00000"
    else
      zipcode.to_s.rjust(5,"0")[0..4]
    end
  end

  def clean_home_phone_number(homephone)
    homephone = homephone.to_s
    homephone.tr!('^0-9', '')
      if homephone.length == 10
        homephone
      elsif (homephone.length < 10) || (homephone.length > 11)
        "0"*10
      elsif (homephone.length == 11) && (homephone[0] == "1")
        homephone[1..10]
      else
        "0"*10
      end
  end

  # def formatted_phone(non_formatted_homephones)
  #   cleaned_phone_numbers    = clean_home_phone_number(non_formatted_homephones)
  #   home_phone_number_digits = cleaned_phone_numbers.to_s.split('')
  #   home_phone_area_code     = home_phone_number_digits[0..2].join
  #   home_phone_prefix        = home_phone_number_digits[3..5].join
  #   home_phone_suffix        = home_phone_number_digits[6..9].join
  #   formatted_phone          = "(#{home_phone_area_code}) #{home_phone_prefix}-#{home_phone_suffix}"
  # end

end
