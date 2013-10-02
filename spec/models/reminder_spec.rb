require 'spec_helper'

describe Reminder do
  describe "#grouped_reminders" do
    it "returns a list of reminders with no limit" do
      reminder = FactoryGirl.create(:reminder, send_date: DateTime.now + 1.day)
      Reminder.grouped_reminders.count.should == 1
    end

    it "returns a list of reminders with a limit of 1" do
      reminder = FactoryGirl.create(:reminder, send_date: DateTime.now + 1.day)
      Reminder.grouped_reminders(1).count.should == 1
    end
  end

  describe "#add_reminder_to_queue" do
    it "adds a new reminder to the Delayed Job queue" do
      recipient = FactoryGirl.create(:recipient)
      message = FactoryGirl.create(:message)
      reminder = FactoryGirl.create(:reminder, recipient_id: recipient.id, message_id: message.id)
      Reminder.add_reminder_to_queue(reminder)
      Delayed::Job.count.should == 1
    end
  end

  describe "#create_new_recipients_reminders" do
    it "creates a new reminder and adds to the Delayed Job queue" do
      recipient = FactoryGirl.create(:recipient)
      message = FactoryGirl.create(:message)
      Reminder.create_new_recipients_reminders(recipient, DateTime.now + 2.days, message)
      # Reminder.all.count.should == 1
      Delayed::Job.count.should == 1
    end
  end

end
