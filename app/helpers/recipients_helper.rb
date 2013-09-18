module RecipientsHelper
	def notifications
		@recipient.notifications
	end

	def which_sender(phone_number)
		self_phone = ENV["TWILIO_NUMBER"]
		if phone_number[-10..-1] != self_phone
			sender = "recipient"
		else
			sender = "self"
		end
	end 


end