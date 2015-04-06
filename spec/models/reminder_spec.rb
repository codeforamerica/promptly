require 'spec_helper'

describe Reminder do
  describe "#grouped_reminders" do
    it "returns a list of reminders with no limit" do
      reminder = FactoryGirl.create(:reminder_with_message_and_recipient, send_date: DateTime.now + 1.day)
      expect(Reminder.grouped_reminders.count).to eq 1
    end

    it "returns a list of reminders with a limit of 1" do
      reminder = FactoryGirl.create(:reminder_with_message_and_recipient, send_date: DateTime.now + 1.day)
      expect(Reminder.grouped_reminders(1).count).to eq 1
    end
  end

  describe "#create_new_reminders" do
    before do
      @recipient = FactoryGirl.create(:recipient)
      @message = FactoryGirl.create(:message)
      @group = FactoryGirl.create(:group_with_recipient)
      @organization = FactoryGirl.create(:organization)
    end
    it "creates a new reminder with one group and adds to the Delayed Job queue" do
      Reminder.create_new_reminders(@message, DateTime.now + 2.days, group_id: @group.id.to_s, organization_id: @organization.id)
      expect(Reminder.all.count).to eq 1
      expect(Delayed::Job.count).to eq 1
    end
    it "creates a new reminder with one recipient and adds to the Delayed Job queue" do
      Reminder.create_new_reminders(@message, DateTime.now + 2.days, recipient: @recipient, organization_id: @organization.id)
      expect(Reminder.all.count).to eq 1
      expect(Delayed::Job.count).to eq 1
    end

    it "does not create duplicate reminders" do
      Reminder.create_new_reminders(@message, DateTime.new(2100,2,3), group_id: @group.id.to_s, organization_id: @organization.id)
      expect(Reminder.all.count).to eq 1
      expect(Delayed::Job.count).to eq 1
      Reminder.create_new_reminders(@message, DateTime.new(2100,2,3), group_id: @group.id.to_s, organization_id: @organization.id)
      expect(Reminder.all.count).to eq 1
    end

    it "creates a new reminder for a different time" do
      Reminder.create_new_reminders(@message, DateTime.now + 2.days, group_id: @group.id.to_s, organization_id: @organization.id)
      expect(Reminder.all.count).to eq 1
      expect(Delayed::Job.count).to eq 1
      Reminder.create_new_reminders(@message, DateTime.now + 3.days, group_id: @group.id.to_s, organization_id: @organization.id)
      expect(Reminder.all.count).to eq 2
      expect(Delayed::Job.count).to eq 2
    end

  end

  describe "#check_for_valid_date" do
    it "checks if the given date is a valid date" do
      test_date = DateTime.now
      expect(Reminder.check_for_valid_date(test_date)).to be_an_instance_of(DateTime)
    end
  end

end
