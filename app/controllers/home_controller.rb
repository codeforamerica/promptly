class HomeController < ApplicationController
  def index
    @recipient = Recipient.all
    @recents = Conversation.find(:all, :order => "id desc", :limit => 5).reverse
    @upcoming = Notification.where("send_date >= ?", DateTime.now)
    @report = Report.all
  end
end
