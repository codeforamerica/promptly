class TextController < ApplicationController
  def index
  end
 
  def send_text_message
    number_to_send_to = "+19196361635"
 
    # twilio_sid = ENV['TWILIO_SID']
    # twilio_token = ENV['TWILIO_TOKEN']
    twilio_phone_number = ENV['TWILIO_NUMBER']

    # @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
    # # binding.pry
    # @twilio_client.account.sms.messages.create(
    #   :from => "+1#{twilio_phone_number}",
    #   :to => number_to_send_to,
    #   :body => "This is an automatic message. It gets sent to #{number_to_send_to}"
    # )
    
    Delayed::Job.enqueue(SendMessage.new("+1#{twilio_phone_number}", number_to_send_to, "This is an automatic message. It gets sent to #{number_to_send_to}"), 1, '2013-05-14 23:57:11')
    # flash[:notice] = "sending message"
  end

  # def in_the_future
  #   # Some other code
  #   send_text_message
  # end
  # 5.minutes.from_now will be evaluated when in_the_future is called
  # handle_asynchronously :in_the_future, :run_at => Proc.new { 1.minute.from_now }

  def receive_text_message
    message_body = params["Body"]
    from_number = params["From"]
    if from_number
      # verify_recipient(from_number)
    else
      redirect_to(recipients_path)
    end
    # Log this conversation
    # SMSLogger.log_text_message from_number, message_body
  end

  private

  def verify_recipient(phone_number)
    @recipients = Recipient.find(:all, :conditions => ["phone = ?", phone_number.gsub('+1','').to_i])
    if @recipients
      send_reply(phone_number, params["Body"])
    else
      send_reply(phone_number, "Sorry we couldn't verify your number.")
    end

  end

  private 

  def send_reply(phone_number, message)
    twilio_sid = ENV['TWILIO_SID']
    twilio_token = ENV['TWILIO_TOKEN']
    twilio_phone_number = ENV['TWILIO_NUMBER']

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
    # binding.pry
    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => phone_number,
      :body => "We got your message! '#{message}'"
    )
  end
end