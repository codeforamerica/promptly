require 'spec_helper'

describe Recipient do

  describe "#phone_or_name" do
    it "returns name if it is present" do
      recipient = FactoryGirl.create(:recipient, name: "bob")
      expect(recipient.phone_or_name).to eq "bob"
    end

    it "returns phone if name is not present" do
      recipient = FactoryGirl.create(:recipient, phone: "9999999999")
      recipient.update_attributes(name: nil)
      expect(recipient.phone_or_name).to eq "19999999999"
    end
  end

end
