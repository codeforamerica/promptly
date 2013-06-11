require 'spec_helper'
include ActionDispatch::TestProcess

describe Notifier do
  before :each do
     @message = FactoryGirl.create(:message)
     @recipient = FactoryGirl.create(:recipient)
   end
  it "has a valid recipient" do
    @recipient.should be_valid
  end
  it "has one or many reports" do
   @recipient.should have_and_belong_to_many(:reports)
  end
  it "has valid message for each report" do
    @recipient.reports.each do |report|
      report.messages.should_not be_nil
    end
  end
  it "creates a new notification" do
    @recipient.reports.each do |report|
      @notification = Notification.new
      @notification.report_id = report.id
      @notification.recipient_id = @recipient.id
      @notification.send_date = "01/01/2013"
      @notification.save
    end
  end
  it "has valid twilio credentials" do
    ENV['TWILIO_NUMBER'].should_not be_nil
    ENV['TWILIO_TOKEN'].should_not be_nil
    ENV['TWILIO_SID'].should_not be_nil
  end
  it "sends a message" do
    account_sid = ENV['TWILIO_SID']
    auth_token = ENV['TWILIO_TOKEN']
    @client = Twilio::REST::Client.new account_sid, auth_token
    # visit("http://twilio.com/Accounts/#{account_sid}/SMS/Messages")
     
    theText = @client.account.sms.messages.create(:body => "Candygram.",
        :to => @recipient.phone,
        :from => ENV['TWILIO_NUMBER'])
    theText.should_not be_nil
  end
  describe "logs a message" do
    it "creates a new conversation"
  end
end
