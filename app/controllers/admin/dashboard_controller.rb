class Admin::DashboardController < AdminController
  def index
    @recipient = Recipient.all
    @recents = Conversation.find(:all, :order => "date desc", :limit => 10)
    @conversations = Conversation.find(:all, :order => "date desc", :limit => 10)
    @upcoming = Reminder.grouped_reminders(10).collect

    authorize! :index, @recipient
  end
end
