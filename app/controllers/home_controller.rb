class HomeController < ApplicationController
  def index
    @add_recipient = Recipient.all
    @recents = Conversation.all
    @upcoming = Delayed::Job.find :all , :conditions=>"locked_at IS NOT NULL"
  end

end
