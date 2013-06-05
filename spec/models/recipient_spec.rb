require 'spec_helper'

describe Recipient do
	it "has a valid factory" do
    FactoryGirl.create(:recipient).should be_valid
    FactoryGirl.create(:report)
  end
  it "is invalid without a phone number" do
    FactoryGirl.build(:recipient, phone: nil).should_not be_valid
  end
  it "has many reports" do
    should have_and_belong_to_many(:reports)
  end

  it "accepts an uploaded spreadsheet"
end
