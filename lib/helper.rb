module Helper
  def current_user_exists?(phone_number)
  	phone_number.gsub!(/[^0-9]/, "")
  	if phone_number.length > 10
  		check_number = phone_number[1..-1]
  	else 
  		check_number = phone_number
  	end
    Recipient.where('phone =?', check_number)
  end
end