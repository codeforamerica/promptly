class HomeController < ApplicationController
  def index
    @recipient = Recipient.all
    @recents = Conversation.find(:all, :order => "date desc", :limit => 10)
    @upcoming = Notification.where("sent_date >= ? and reminder_id !=?", DateTime.now, nil)
    @report = Report.all
  end
end
