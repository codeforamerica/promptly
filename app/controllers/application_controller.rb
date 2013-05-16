class ApplicationController < ActionController::Base
  protect_from_forgery

  def log_conversation(to, from, message, date)
    @conversation = Conversation.new
    @conversation.date = date
    @conversation.message = message
    @conversation.to_number = to
    @conversation.from_number = from
    @conversation.save
  end

  
end
