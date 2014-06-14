desc "This task is called by the Heroku scheduler add-on"
	task :update_conversations => :environment do

	def find_organization(conversation, number)
		if conversation.organization_id
			conversation.organization_id
		else
			Organization.exists?(phone_number: number) ? Organization.where(phone_number: number).first.id : nil
		end
	end

	def find_group(conversation, number)
		if conversation.group_id
			@the_group = conversation.group_id
		else
			if Organization.exists?(id: conversation.organization_id)
				@organization = Organization.find(conversation.organization_id)
				@organization.groups.each do |group|
						@recipients = Group.find(group.id).recipients
						@recipients.each do |recipient|
							puts recipient.phone
							puts number.gsub(/^\+\d/, '')
							if recipient.phone == number.gsub(/^\+\d/, '')
								@the_group = group.id
							else
								@the_group = nil
							end
						end
				end
			end
			@the_group
		end
	end
	
	# Get the Account Sid and Auth Token 
	account_sid = ENV["TWILIO_SID"]
	auth_token = ENV["TWILIO_TOKEN"]
	@client = Twilio::REST::Client.new account_sid, auth_token

	@client.account.sms.messages.list.each do |message|
		@conversation = Conversation.where('message_id = ?', message.sid).first_or_create
		@conversation.message_id = message.sid
    @conversation.status = message.status
    @conversation.date = message.date_sent
    @conversation.from_number = message.from
    @conversation.to_number = message.to
    @conversation.message = message.body
    @conversation.organization_id = find_organization(@conversation, message.to)
    @conversation.group_id = find_group(@conversation, message.to)
    @conversation.save!
    puts @conversation.group_id
	end

	# Import call information from Twilio into conversations table
	@client.account.calls.list.each do |twilio_call|
		@conversation = Conversation.where('call_id = ? and to_number = ?' , twilio_call.sid, twilio_call.to).first_or_create
		@conversation.call_id = twilio_call.sid
		@conversation.to_number = twilio_call.to
		@conversation.from_number = twilio_call.from
		@conversation.date = twilio_call.date_created
		@conversation.status = twilio_call.status
		# Strip the + and country code for comparison
		@recipient = Recipient.where('phone = ?' , twilio_call.from.gsub(/^\+\d/, '')).all
		@conversation.recipients = @recipient
		@conversation.save!
		puts @conversation.call_id
	end

end