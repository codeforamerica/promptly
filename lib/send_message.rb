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