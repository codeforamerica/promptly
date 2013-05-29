class HomeController < ApplicationController
  def index
    @recipient = Recipient.all
    @recents = Conversation.all
    @upcoming = Notifications.where("send_date >= ?", DateTime.now)
    @report = Report.all
  end
end
