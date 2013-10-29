require 'spec_helper'

describe Group do
  
  describe "#add_phone_numbers" do
    it "adds list of phone numbers to a group" do
      group = FactoryGirl.create(:group, name: "test group")
      phone_numbers = "9999999999,1111111111"
      Group.add_phone_numbers_to_group(phone_numbers, group)
      Recipient.count.should == 2
    end

    it "adds an array of phone numbers to a group" do
      group = FactoryGirl.create(:group, name: "test group")
      phone_numbers = ["9999999999", "1111111111"]
      Group.add_phone_numbers_to_group(phone_numbers, group)
      Recipient.count.should == 2
    end
  end
  describe "#add_reminders_to_group" do
    it "adds created reminders to their respective group" do
      group = FactoryGirl.create(:group, name: "test group 2")
      recipient = FactoryGirl.create(:recipient)
      message = FactoryGirl.create(:message)
      Reminder.create_new_recipients_reminders(message, DateTime.now + 2.days, group_id: group.id)
      Reminder.count.should == 1
      Delayed::Job.count.should == 1
    end
  end

  describe "#find_recipients_in_group" do
    it "returns an array of recipients for a specific group" do
      group = FactoryGirl.create(:group) do |group|
        group.name = "test group 2"
        group.recipients.create(name: "test2", phone: "8888888888")
        group.recipients.create(name: "test3", phone: "3333333333")
      end
      test_return = Group.find_recipients_in_group(group.id)
      test_return.should == group.recipients
    end
  end

end