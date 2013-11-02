module GroupsHelper

	def phone_numbers
		phone_numbers_array = Array.new
		@group.recipients.each do |recipient|
			phone_numbers_array << recipient.phone.phony_formatted(:normalize => :US, :spaces => '-')
		end

		phone_numbers_array.join("\n")
	end

	

end