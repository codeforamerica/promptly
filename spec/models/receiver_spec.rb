require 'spec_helper'
include ActionDispatch::TestProcess

describe Receiver do
  before :each do
     @message = FactoryGirl.create(:message)
     @recipient = FactoryGirl.create(:recipient)
   end
  it "has a valid recipient" do
    @recipient.should be_valid
  end
  
  it "has valid twilio credentials" do
    ENV['TWILIO_NUMBER'].should_not be_nil
    ENV['TWILIO_TOKEN'].should_not be_nil
    ENV['TWILIO_SID'].should_not be_nil
  end

  it "creates a new conversation"
  it "finds an existing user"
  it "adds the user id to the conversation table"
  it "sends a reply"


end
