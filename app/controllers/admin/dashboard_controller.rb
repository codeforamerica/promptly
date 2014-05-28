class Admin::DashboardController < OrgController
  before_filter :authorize
	
  def index
    @recipient = Recipient.all
    @recents = Conversation.find(:all, :order => "date desc")
    @conversations = Conversation.where("message_id is not null", :order => "date desc")
    @upcoming = Reminder.grouped_reminders.collect
    @last_month = Conversation.where("status =? and date >= ?", "completed", DateTime.now - 1.month ).count
    @this_year = Conversation.where("status =? and date >= ?", "completed", "#{Time.now.year}0101").count
    @calls = Conversation.where("call_id is not null and message_id is null", :order => "date desc")
  end

  def authorize
    raise CanCan::AccessDenied unless can? :read, Reminder, @organization_user
  end
end
