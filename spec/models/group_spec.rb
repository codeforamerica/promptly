require 'spec_helper'

describe Group do
  
  describe "#add_phone_numbers" do
    it "adds list of phone numbers to a group" do
      group = FactoryGirl.create(:group, name: "test group")
      phone_numbers = "9999999999,1111111111"
      Group.add_phone_numbers_to_group(phone_numbers, group)
      expect(Recipient.count).to eq 2
    end

    it "adds an array of phone numbers to a group" do
      group = FactoryGirl.create(:group, name: "test group")
      phone_numbers = ["9999999999", "1111111111"]
      Group.add_phone_numbers_to_group(phone_numbers, group)
      expect(Recipient.count).to eq 2
    end
  end

  describe "#find_recipients_in_group" do
    it "returns an array of recipients for a specific group" do
      group = FactoryGirl.create(:group) do |g|
        g.name = "test group 2"
        g.recipients.create(name: "test2", phone: "8888888888")
        g.recipients.create(name: "test3", phone: "3333333333")
      end
      test_return = Group.find_recipients_in_group(group.id)
      expect(test_return).to eq group.recipients
    end
  end

end