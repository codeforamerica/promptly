class SendMessage < Struct.new(:from_number, :to_number, :reminder)
  def perform
    twilio_sid = ENV['TWILIO_SID']
    twilio_token = ENV['TWILIO_TOKEN']
    
    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
    # binding.pry
    @twilio_client.account.sms.messages.create(
      :from => from_number,
      :to => to_number,
      :body => reminder
    )

  end
end
# number_to_send_to = "+19196361635"
# twilio_phone_number = ENV['TWILIO_NUMBER']
# Delayed::Job.enqueue(SendMessage.new("+1#{twilio_phone_number}", number_to_send_to, "This is an automatic message. It gets sent to #{number_to_send_to}"), 1, 1.minute.from_now)
