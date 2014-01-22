desc "This task is called by the Heroku scheduler add-on"
	task :update_conversations => :environment do
	
	# Get the Account Sid and Auth Token 
	account_sid = ENV["TWILIO_SID"]
	auth_token = ENV["TWILIO_TOKEN"]
	@client = Twilio::REST::Client.new account_sid, auth_token

	@client.account.sms.messages.list.each do |message|
		@conversation = Conversation.where('message_id = ?' , message.sid)
		@conversation.each do |c|
	    c.status = message.status
	    c.date = message.date_sent
	    c.from_number = message.from
	    c.to_number = message.to
	    c.message = message.body
	    c.save!
	   end
	end

	# Import call information from Twilio into conversations table
	@client.account.calls.list.each do |twilio_call|
		# Don't import existing calls (TODO: only look at calls from last x minutes)
		Conversation.all.each do |c|
			if c.call_id == twilio_call.sid
				break
			end
		end
		conv = Conversation.new
		conv.call_id = twilio_call.sid
		conv.to_number = twilio_call.to
		conv.from_number = twilio_call.from
		conv.date = twilio_call.date_created
		conv.status = twilio_call.status
		# Strip the + and country code for comparison
		@recipient = Recipient.where('phone = ?' , twilio_call.from.gsub(/^\+\d/, '')).all
		conv.recipients = @recipient
		conv.save!
	end

end