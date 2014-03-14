class Admin::SuperdashboardController < AdminController
  # load_and_authorize_resource
  
  def index
    @recipient = Recipient.all
    @recents = Conversation.find(:all, :order => "date desc")
    @conversations = Conversation.find(:all, :order => "date desc")
    @upcoming = Reminder.grouped_reminders.collect
    @last_month = Conversation.where("status =? and date >= ?", "completed", DateTime.now - 1.month ).count
    @this_year = Conversation.where("status =? and date >= ?", "completed", "#{Time.now.year}0101").count
  end
end
