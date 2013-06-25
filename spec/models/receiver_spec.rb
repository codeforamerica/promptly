require 'spec_helper'
require 'pp'
include Helper
include ActionDispatch::TestProcess

describe Receiver do
  before :each do
     @message = FactoryGirl.create(:message)
     @recipient = FactoryGirl.create(:recipient)
   end
  it "has a valid recipient" do
    @recipient.should be_valid
  end
  
  describe "Check for new incoming messages" do
    it "has valid twilio credentials" do
      ENV['TWILIO_NUMBER'].should_not be_nil
      ENV['TWILIO_TOKEN'].should_not be_nil
      ENV['TWILIO_SID'].should_not be_nil
    end
    it "checks the twilio log" do
      # Delayed::Worker.delay_jobs = false
      Receiver.delay(priority: 1, run_at: 2.minutes.from_now).perform
    end
    it "checks the twilio log every 2 minutes" do
      expect {
        Receiver.delay(priority: 1, run_at: 2.minutes.from_now).perform
      }.to change(Delayed::Job,:count).by(1)
    end
    it "adds a new delayed job to check for messages"

  end

  describe "Validate the user" do
    it "finds if the user exists" do
      pp current_user_exists?(@recipient.phone)
    end
  end

  describe "Send a reply" do
    it "gets the number of the sender"
    it "parses the message"
    it "figures out which reply to send"
    it "sends a reply"
    it "logs the conversation" do
      
    end
  end
end
