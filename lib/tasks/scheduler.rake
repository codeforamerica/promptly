desc "This task is called by the Heroku scheduler add-on"
	task :update_conversations => :environment do
	
	# Get the Account Sid and Auth Token 
	account_sid = ENV["TWILIO_SID"]
	auth_token = ENV["TWILIO_TOKEN"]
	@client = Twilio::REST::Client.new account_sid, auth_token

	 @conversation = Conversation.where('message_id IS NOT NULL AND status IS NULL')
	 @conversation.each do |c|
		# Loop over messages and print out a property for each one
		@client.account.sms.messages.list(:from => '+14154198992').each do |message|
	    if c.message_id = message.sid
		    c.status = message.status
		    c.save!
		  end
		end
	end
end