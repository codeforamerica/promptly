class Receiver

  def initialize
  end

  def self.perform
    new.perform
  end

  def perform
    # Loop over messages sent to our twilio number and on today
      binding.pry
    client.account.sms.messages.list.each do |message|
      # Logger.log()
      puts message.from
      puts message.to
      puts message.date_sent
      puts message.body
    end
  end

  private

  attr_reader :recipient
  attr_reader :body

  def account_sid
    ENV["TWILIO_SID"]
  end

  def account_token
    ENV["TWILIO_TOKEN"]
  end

  def client
    @client = Twilio::REST::Client.new(account_sid, account_token)
  end

  # def receive_text_message
  #   message_body = params["Body"]
  #   from_number = params["From"]
  #   if from_number
  #       Notifier.delay(priority: 1, run_at: DateTime.now).perform(@recipient, Reminder.find(reminder.id).messages.first.message_text)
  #   else
  #     redirect_to(recipients_path)
  #   end
  # end

  # def verify_recipient(phone_number)
  #   @recipients = Recipient.find(:all, :conditions => ["phone = ?", phone_number.gsub('+1','')])
  #   if @recipients
  #     @recipients.each do |recipient|
  #      Notifier.perform(recipient, "Your CalFresh (Food Stamps) quarterly report (QR-7) is due #{recipient.reminder_date.to_s(:date_format)}. We will remind you one week before. Text STOP to stop receiving these text messages.")
  #     end
  #   else
  #     Notifier.perform(phone_number, "Sorry we couldn't verify your number.")
  #   end
  # end

end