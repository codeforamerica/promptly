class HomeController < ApplicationController
  def index
    @add_recipient = Recipient.all
    @recents = Conversation.all
  end

end
