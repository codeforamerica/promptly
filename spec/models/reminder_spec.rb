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

  describe "#create_new_reminders" do
    before do
      @recipient = FactoryGirl.create(:recipient)
      @message = FactoryGirl.create(:message)
      @group = FactoryGirl.create(:group_with_recipient)
    end
    it "creates a new reminder with one group and adds to the Delayed Job queue" do
      Reminder.create_new_reminders(@message, DateTime.now + 2.days, group_id: @group.id)
      Delayed::Job.count.should == 1
    end
    it "creates a new reminder with one recipient and adds to the Delayed Job queue" do
      Reminder.create_new_reminders(@message, DateTime.now + 2.days, recipient: @recipient)
      Delayed::Job.count.should == 1
    end
  end

  describe "#check_for_valid_date" do
    it "checks if the given date is a valid date" do
      test_date = DateTime.now
      Reminder.check_for_valid_date(test_date).should be_an_instance_of(DateTime)
    end
  end

end
