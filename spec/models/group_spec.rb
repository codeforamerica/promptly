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
end