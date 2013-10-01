require 'spec_helper'
include ActionDispatch::TestProcess

describe Recipient do

  describe "#phone_or_name" do
    it "returns name if it is present" do
      recipient = FactoryGirl.create(:recipient, name: "bob")
      recipient.phone_or_name.should == "bob"
    end

    it "returns phone if name is not present" do
      recipient = FactoryGirl.create(:recipient, phone: "9999999999")
      recipient.update_attributes(name: nil)
      recipient.phone_or_name.should == "9999999999"
    end
  end

end
