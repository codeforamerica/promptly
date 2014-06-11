class Admin::SuperdashboardController < AdminController
  # load_and_authorize_resource
  
  def index
    @recipient = Recipient.all
    @recents = Conversation.find(:all, :order => "date desc")
    @conversations = Conversation.where("message_id is not null", :order => "date desc")
    @upcoming = Reminder.grouped_reminders.collect
    @last_month = Conversation.where("status =? and date >= ?", "completed", DateTime.now - 1.month ).count
    @this_year = Conversation.where("status =? and date >= ?", "completed", "#{Time.now.year}0101").count
    @calls = Conversation.where("call_id is not null and message_id is null", :order => "date desc")
    @last_month == 0 ? @response_rate = 0 : @response_rate = (Conversation.month_calls.count/@last_month)*100
    @undelivered_rate = Conversation.undelivered_month.count >0? (Conversation.month_calls.count/Conversation.undelivered_month.count)*100 : 0
  end
end
