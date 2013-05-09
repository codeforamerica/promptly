class TextController < ApplicationController
  def index
  end
 
  def send_text_message
    number_to_send_to = +19196361635
 
    twilio_sid = ENV['TWILIO_SID']
    twilio_token = ENV['TWILIO_TOKEN']
    twilio_phone_number = ENV['TWILIO_NUMBER']

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
    # binding.pry
    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => number_to_send_to,
      :body => "This is an message. It gets sent to #{number_to_send_to}"
    )
  end

  def receive_text_message
    message_body = params["Body"]
    from_number = params["From"]
    if from_number
      twilio_sid = ENV['TWILIO_SID']
      twilio_token = ENV['TWILIO_TOKEN']
      twilio_phone_number = ENV['TWILIO_NUMBER']

      @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
      # binding.pry
      @twilio_client.account.sms.messages.create(
        :from => "+1#{twilio_phone_number}",
        :to => from_number,
        :body => "We got your message! #{message_body}"
      )
    else
      redirect_to(recipients_path)
    end
    # SMSLogger.log_text_message from_number, message_body
  end
end