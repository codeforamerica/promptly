require 'spec_helper'
Faker::Config.locale = 'en-US'

describe Group do

  describe "#add_phone_numbers" do
    it "adds list of phone numbers to a group" do
      group = FactoryGirl.create(:group, name: "test group")
      phone_numbers = Faker::PhoneNumber.area_code+Faker::PhoneNumber.exchange_code+Faker::PhoneNumber.subscriber_number, Faker::PhoneNumber.area_code+Faker::PhoneNumber.exchange_code+Faker::PhoneNumber.subscriber_number
      Group.add_phone_numbers_to_group(phone_numbers, group)
      expect(Recipient.count).to eq 2
    end

    it "adds an array of phone numbers to a group" do
      group = FactoryGirl.create(:group, name: "test group")
      phone_numbers = [Faker::PhoneNumber.area_code+Faker::PhoneNumber.exchange_code+Faker::PhoneNumber.subscriber_number, Faker::PhoneNumber.area_code+Faker::PhoneNumber.exchange_code+Faker::PhoneNumber.subscriber_number]
      Group.add_phone_numbers_to_group(phone_numbers, group)
      expect(Recipient.count).to eq 2
    end
  end

  describe "#find_recipients_in_group" do
    it "returns an array of recipients for a specific group" do
      group = FactoryGirl.create(:group) do |g|
        g.name = "test group 2"
        g.recipients.create(name: "test2", phone: Faker::PhoneNumber.area_code+Faker::PhoneNumber.exchange_code+Faker::PhoneNumber.subscriber_number)
        g.recipients.create(name: "test3", phone: Faker::PhoneNumber.area_code+Faker::PhoneNumber.exchange_code+Faker::PhoneNumber.subscriber_number)
      end
      test_return = Group.find_recipients_in_group(group.id)
      expect(test_return).to eq group.recipients
    end
  end

end