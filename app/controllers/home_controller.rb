class HomeController < ApplicationController
  def index
    @recipient = Recipient.all
    @recents = Conversation.find(:all, :order => "date desc", :limit => 10)
    @upcoming = Delivery.grouped_deliveries.collect
  end
end
