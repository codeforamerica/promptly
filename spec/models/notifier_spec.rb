require 'spec_helper'
include ActionDispatch::TestProcess
# Delayed::Worker.delay_jobs = false

describe Notifier do
  before :each do
     @recipient = FactoryGirl.create(:recipient)
   end
  # it "has a valid recipient" do
  #   @recipient.should be_valid
  # end

  # it "has valid message for each reminder" do
  #   @recipient.reminders.each do |reminder|
  #     reminder.message.should_not be_nil
  #   end
  # end
  # it "has a valid message in the body" do
  #   @recipient.reminders.try(:each) do |reminder|
  #     test = Notifier.new(@recipient, Reminder.find_by_reminder_id(reminder.id).message_text)
  #     test.attributes[:body].should include(@message.message_text)
  #   end
  # end
  it "has valid twilio credentials" do
    ENV['TWILIO_NUMBER'].should_not be_nil
    ENV['TWILIO_TOKEN'].should_not be_nil
    ENV['TWILIO_SID'].should_not be_nil
  end
  # it "add message to delayed job queue" do
  #   @recipient.reminders.try(:each) do |reminder|
  #     expect {
  #        Notifier.delay(priority: 0, run_at: theDate).perform(reminder.message_id, reminder.group_ids, reminder.recipient)
  #     }
  #   end
  # end

  # it "adds delayed job id to notifications and creates new notification" do
  #   @recipient.reminders.try(:each) do |reminder|
  #     test = Notifier.delay(priority: 1, run_at: 2.minutes.from_now).perform(@recipient, Reminder.find(reminder.id).messages.first.message_text)
  #     # binding.pry
  #     expect {
  #     Notifier.notification_add(@recipient, @message, test.id)
  #     }.to change(Notification, :count).by(1)
  #   end
  # end

  # it "deletes old notifications and delayed jobs on update" do
  #   @recipient.reminders.try(:each) do |reminder|
  #     old_notification = Notification.find_by_reminder_id_and_recipient_id(reminder.id, @recipient.id)
  #   end
  # end

  # describe "logs a message" do
  #   it "creates a new conversation"
  # end

  describe "#perform" do
    before do
      Delayed::Worker.delay_jobs = false
      @reminder = FactoryGirl.create(:reminder_with_message_and_group)
    end
    it "creates a new text message" do
      Notifier.delay(priority: 0, run_at: DateTime.now).perform(@reminder.message_id, group_id: @reminder.group_ids)
    end
  end
end
