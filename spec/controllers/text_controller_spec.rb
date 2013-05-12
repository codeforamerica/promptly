require 'spec_helper'

describe TextController do
	# include SmsSpec::Helpers
	
	# describe "POST 'receive_text_message'" do
		
	#   registered_phone_number = '+19196361635'

	#   before do
	#     Recipient.create :phone => registered_phone_number, :case => 1234
	#   end
	#   it "confirms phone number" do
	#   	# open_last_text_message_for "9196361635"
	#   	twilio_sid = ENV['TWILIO_SID']
	#   twilio_token = ENV['TWILIO_TOKEN']
	#   twilio_phone_number = ENV['TWILIO_NUMBER']
	# 	  @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
	#     @twilio_client.account.sms.messages.create(
	#       :from => "+1#{twilio_phone_number}",
	#       :to => registered_phone_number,
	#       :body => "Yes"
	#     )
	# 		post :send_reply, twiml_message(twilio_phone_number, "YES", "To" => registered_phone_number)
	# 	end
	# end
end
