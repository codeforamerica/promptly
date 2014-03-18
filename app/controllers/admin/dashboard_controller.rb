class Admin::DashboardController < OrgController
  before_filter :authorize
	
  def index
    @recipient = Recipient.all
    @recents = Conversation.find(:all, :order => "date desc")
    @conversations = Conversation.find(:all, :order => "date desc",)
    @upcoming = Reminder.organization(@organization.id).grouped_reminders.collect
  end

  def authorize
    raise CanCan::AccessDenied unless can? :read, Reminder, @organization_user
  end
end
