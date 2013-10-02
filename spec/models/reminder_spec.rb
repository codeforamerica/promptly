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

end
