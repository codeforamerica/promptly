module ApplicationHelper

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
