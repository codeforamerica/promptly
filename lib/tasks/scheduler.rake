desc "This task is called by the Heroku scheduler add-on"
	task :update_conversations => :environment do
	
	# Get the Account Sid and Auth Token 
	account_sid = ENV["TWILIO_SID"]
	auth_token = ENV["TWILIO_TOKEN"]
	@client = Twilio::REST::Client.new account_sid, auth_token

	@client.account.sms.messages.list.each do |message|
		@conversation = Conversation.where('message_id = ?' , message.sid).first_or_create
	  	@conversation.message_id = message.sid
	    @conversation.status = message.status
	    @conversation.date = message.date_sent
	    @conversation.from_number = message.from
	    @conversation.to_number = message.to
	    @conversation.message = message.body
	    @conversation.save!
	end
end