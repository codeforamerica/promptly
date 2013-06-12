class ApplicationController < ActionController::Base

  helper :all

  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def log_conversation(to, from, message, date)
    @conversation = Conversation.new
    @conversation.date = date
    @conversation.message = message
    @conversation.to_number = to
    @conversation.from_number = from
    @conversation.save
  end

	def sendNotification(notification, report, recipient)
	  # Notifier.perform(recipient, "Your #{report.humanname} report is due #{@notification.send_date.to_s(:date_format)}. We will remind you one week before. Text STOP to stop these text messages.")
	  if notification.send_date < DateTime.now
	    Notifier.perform(recipient, "Your #{report.humanname} report is due on Monday, May 27th. Need help? Call (415) 558-1001.")
	  else
	    # use Notifier.new here so delayed job can hook into the perform method
	    Delayed::Job.enqueue(Notifier.new(recipient, "Your #{report.humanname} report is due #{recipient.notifications.send_date.to_s(:date_format)}. Need help? Call (415) 558-1001."), notification.send_date)
	  end
	end
  
end
