desc "This task is called by the Heroku scheduler add-on"
	task :update_conversations => :environment do
	
	# Get the Account Sid and Auth Token 
	account_sid = ENV["TWILIO_SID"]
	auth_token = ENV["TWILIO_TOKEN"]
	@client = Twilio::REST::Client.new account_sid, auth_token

	 @conversation = Conversation.where('message_id IS NOT NULL AND status IS NULL OR status =? OR status =?', "queued", "received").first_or_create
	 if @conversation.valid?
	 		@client.account.sms.messages.list(:to => ENV['TWILIO_NUMBER']).each do |message|
	    if @conversation.message_id = message.sid
		    @conversation.status = message.status
		    @conversation.date = message.date_sent
		    @conversation.from_number = message.from
		    @conversation.to_number = message.to
		    @conversation.message = message.body
		    @conversation.save!
		  end
		end
	else
		 @conversation.each do |c|
			# Loop over messages and print out a property for each one
			@client.account.sms.messages.list(:from => env['TWILIO_NUMBER']).each do |message|
		    if c.message_id = message.sid
			    c.status = message.status
			    c.save!
			  end
			end
		end
	end
end