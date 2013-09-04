module RecipientsHelper
	def notifications
		@recipient.notifications
	end

	def which_class(phone_number)
		self_phone = ENV["TWILIO_NUMBER"]
		if phone_number[-10..-1] != self_phone
			css_class = "conversation-recipient"
		else
			css_class = "conversation-self"
		end
	end 

end