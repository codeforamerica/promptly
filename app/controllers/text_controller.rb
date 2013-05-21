class TextController < ApplicationController
  def index
  end
 
  def send_text_message
    number_to_send_to = "+19196361635"
    twilio_phone_number = ENV['TWILIO_NUMBER']
    
    # Delayed::Job.enqueue(Notifier.perform(("+1#{twilio_phone_number}", number_to_send_to, "This is an automatic message. It gets sent to #{number_to_send_to}"), 1, '2013-05-14 23:57:11')
    # flash[:notice] = "sending message"
  end

  def receive_text_message
    message_body = params["Body"]
    from_number = params["From"]
    if from_number
      verify_recipient(from_number)
    else
      redirect_to(recipients_path)
    end
  end

  private

  def verify_recipient(phone_number)
    @recipients = Recipient.find(:all, :conditions => ["phone = ?", phone_number.gsub('+1','')])
    if @recipients
      @recipients.each do |recipient|
       Notifier.perform(recipient, "Thanks! Your CalFresh (Food Stamps) quarterly report (QR-7) is due #{recipient.reminder_date.to_s(:date_format)}. We will remind you one week before. Text STOP to stop receiving these text messages.")
      end
    else
      Notifier.perform(phone_number, "Sorry we couldn't verify your number.")
    end

  end
end