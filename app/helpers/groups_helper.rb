module GroupsHelper

	def phone_numbers
		phone_numbers_array = Array.new
		@group.recipients.each do |recipient|
      if !recipient.phone.nil?
        if recipient.phone.phony_formatted(:strict => true)
    			phone_numbers_array << recipient.phone.phony_formatted(:normalize => :US, :spaces => '-')
        end
      end
		end

		phone_numbers_array.join("\n")
	end

	

end