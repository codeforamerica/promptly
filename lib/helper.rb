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


    # Returns an array of recipient IDs.
	def parse_phone_numbers(phone_numbers_text)
    recipients_to_add = []
    phone_numbers_text.split("\r\n").each do |phone_number|
      #phone number normalization
      phone_number = standardize_numbers(phone_number)

      #save the recipients
      @recipient = Recipient.where(phone: phone_number).first_or_create
      @recipient.inspect
      @recipient.save
      unless phone_number == ""
      end

      recipients_to_add << @recipient.id
    end
    return recipients_to_add
  end

    # Standardizes the phone number
  def standardize_numbers(phone_number)
    unless phone_number == ""
      phone_number.phony_formatted!(:normalize => :US, :spaces => '')
    else
      phone_number = ""
    end
  end

  def group_to_recipient_ids(group_ids)
    recipients_to_add = []
    @groups = Group.where(:id => group_ids)
      @groups.each do |group|
      group.recipients.each do |recipient|
        recipients_to_add << recipient.id
      end
    end

    return recipients_to_add
  end

  def create_group_from_individual_recipients(individual_recipients)
    @group = Group.new
    @group.recipient_ids = phones_to_group
    @group.save
  end
  
end