require 'spec_helper'

describe Group do
  
  describe "#add_phone_numbers" do
    it "adds list of phone numbers to a group" do
      group = FactoryGirl.create(:group, name: "test group")
      phone_numbers = "9999999999,1111111111"
      Group.add_phone_numbers_to_group(phone_numbers, group)
      Recipient.count.should == 2
    end
  end
  describe "#add_reminders_to_group" do
    it "adds created reminders to their respective group" do
      group = FactoryGirl.create(:group, name: "test group 2")
      recipient = FactoryGirl.create(:recipient)
      message = FactoryGirl.create(:message)
      Reminder.create_new_recipients_reminders(recipient, message, DateTime.now + 2.days, group_id: group.id.to_s)
      Reminder.count.should == 1
      Delayed::Job.count.should == 1
    end
  end

end