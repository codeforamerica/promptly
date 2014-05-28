require 'spec_helper'
include ActionDispatch::TestProcess
# Delayed::Worker.delay_jobs = false

describe Notifier do
  before :each do
     @recipient = FactoryGirl.create(:recipient)
   end
  
  it "has valid twilio credentials" # do
  #   ENV['TWILIO_NUMBER'].should_not be_nil
  #   ENV['TWILIO_TOKEN'].should_not be_nil
  #   ENV['TWILIO_SID'].should_not be_nil
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
      @reminder = FactoryGirl.create(:reminder_with_message_and_group)
    end
    it "creates a new text message for all recipients in a group" do
      # Notifier.perform(@reminder.message_id, group_id: @reminder.group_ids, organization_id: @reminder.organization_id)
    end
    it "creates a new text message for all recipients" do
      # Notifier.perform(@reminder.message_id, recipient_id: @reminder.recipient_id)
    end

  end
end
