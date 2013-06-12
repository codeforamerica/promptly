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
  it "add message to delayed job queue" do
    @recipient.reports.try(:each) do |report|
      expect {
        Delayed::Job.enqueue(Notifier.new(@recipient, Message.find_by_report_id(report.id).messagetext), DateTime.now)
        }.to change(Delayed::Job,:count).by(1)
        Delayed::Worker.new(quiet: false).work_off.should == [1, 0]
    end
  end
  describe "logs a message" do
    it "creates a new conversation"
  end
end
