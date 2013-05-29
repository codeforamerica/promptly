class HomeController < ApplicationController
  def index
    @recipient = Recipient.all
    @recents = Conversation.all
    @upcoming = Notifications.all
    @report = Report.all
  end

end
