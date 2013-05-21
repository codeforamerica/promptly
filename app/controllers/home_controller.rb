class HomeController < ApplicationController

  def index
    list_upcoming
    list_recent
    add_recipient
  end

  private
  def add_recipient
    @add_recipient = Recipient.all
  end

  def list_upcoming
  	# list queued
  end

  def list_recent
  	@recents = Conversation.all
  end

end
