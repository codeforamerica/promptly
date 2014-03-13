class Admin::SuperdashboardController < AdminController
  # load_and_authorize_resource
  
  def index
    @recipient = Recipient.all
    @recents = Conversation.find(:all, :order => "date desc")
    @conversations = Conversation.find(:all, :order => "date desc")
    @upcoming = Reminder.grouped_reminders.collect
    @last_month = Conversation.where("status =? and date >= ?", "sent", DateTime.now - 1.month )
    @this_year = Conversation.where("status =? and date >= ?", "sent", Time.now.year )
  end
end
