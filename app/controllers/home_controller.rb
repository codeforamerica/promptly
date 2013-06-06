class HomeController < ApplicationController
  def index
    @recipient = Recipient.all
    @recents = Conversation.all
    @upcoming = Notification.where("send_date >= ?", DateTime.now)
    @report = Report.all
  end
end
