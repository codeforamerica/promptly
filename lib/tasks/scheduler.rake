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
end