class HomeController < ApplicationController
  def index
    @recipient = Recipient.all
    @conversations = Conversation.find(:all, :order => "date desc", :limit => 10)
    @upcoming = Reminder.grouped_reminders.collect{ |reminder| reminder['send_date'] >= DateTime.now}
  end
end
