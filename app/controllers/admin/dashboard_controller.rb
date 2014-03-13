class Admin::DashboardController < OrgController
	
  def index
    @recipient = Recipient.all
    @recents = Conversation.find(:all, :order => "date desc")
    @conversations = Conversation.find(:all, :order => "date desc",)
    @upcoming = Reminder.organization(@organization.id).grouped_reminders.collect

    authorize! :index, @recipient
  end
end
