desc "This task is called by the Heroku scheduler add-on. Updates conversations for today only."
	task :update_daily_conversations => :environment do

	def find_organization(number)
		if Organization.exists?(phone_number: number.to)
			Organization.where(phone_number: number.to).first.id
		elsif Organization.exists?(phone_number: number.from)
			Organization.where(phone_number: number.from).first.id
		else
			0
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
							if recipient.phone.gsub(/^\+\d/, '') == number.gsub(/^\+\d/, '')
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
	client = Twilio::REST::Client.new account_sid, auth_token

	messages = client.messages.list(DateSent: Date.today)
	begin
	  messages.each do |message|
	    puts message.sid + "\t" + message.from + "\t" + message.to + "\t"
			@conversation = Conversation.where('message_id = ?', message.sid).first_or_create
			@conversation.message_id = message.sid
	    @conversation.status = message.status
	    @conversation.date = message.date_sent
	    @conversation.from_number = message.from
	    @conversation.to_number = message.to
	    @conversation.message = message.body
	    @conversation.organization_id.nil? ? @conversation.organization_id = find_organization(message) : @conversation.organization_id = @conversation.organization_id
	    @conversation.group_id.nil? ? find_group(@conversation, message.to) : @conversation.group_id = @conversation.group_id
	    @conversation.save!
	    puts "id=#{@conversation.message_id} group=#{@conversation.group_id} org=#{@conversation.organization_id} phone=#{@conversation.from_number}"
	  end
	  messages = messages.next_page
	end while not messages.empty?

	calls = client.calls.list
	begin
	  calls.each do |twilio_call|
			@conversation = Conversation.where('call_id = ? and to_number = ?' , twilio_call.sid, twilio_call.to).first_or_create
			@conversation.call_id = twilio_call.sid
			@conversation.to_number = twilio_call.to
			@conversation.from_number = twilio_call.from
			@conversation.date = twilio_call.date_created
			@conversation.status = twilio_call.status
			# Strip the + and country code for comparison
			@recipient = Recipient.where('phone = ?' , twilio_call.from.gsub(/^\+\d/, '')).all
			@conversation.recipients = @recipient
			@conversation.organization_id = find_organization(twilio_call)
			@conversation.save!
			puts @conversation.call_id
	  end
	  calls = calls.next_page
	end while not calls.empty?

end