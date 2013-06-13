require 'spec_helper'
include ActionDispatch::TestProcess
# Delayed::Worker.delay_jobs = false

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
    expect {
      Notifier.notification_add(@recipient, @message)
      }.to change(Notification, :count).by(1)
  end
  it "has a valid message in the body" do
    @recipient.reports.try(:each) do |report|
      test = Notifier.new(@recipient, Message.find_by_report_id(report.id).messagetext)
      test.attributes[:body].should include(@message.messagetext)
    end
  end
  it "has valid twilio credentials" do
    ENV['TWILIO_NUMBER'].should_not be_nil
    ENV['TWILIO_TOKEN'].should_not be_nil
    ENV['TWILIO_SID'].should_not be_nil
  end
  it "add message to delayed job queue" do
    @recipient.reports.try(:each) do |report|
      expect {
        Notifier.delay(priority: 1, run_at: 2.minutes.from_now).perform(@recipient, Message.find_by_report_id(report.id).messagetext)
        }.to change(Delayed::Job,:count).by(1)
    end
  end
  describe "logs a message" do
    it "creates a new conversation"
  end
end
