require 'spec_helper'
include ActionDispatch::TestProcess

describe Recipient do
	it "has a valid factory" do
    FactoryGirl.create(:recipient).should be_valid
  end
  it "is invalid without a phone number" do
    FactoryGirl.build(:recipient, phone: nil).should_not be_valid
  end

  # describe "Importing data" do
  #   before :each do
  #    FactoryGirl.create(:report)
  #  end
  #   data = fixture_file_upload(Rails.root + 'spec/files/landshark.csv', 'text/csv')

  #   it "should read csv and add 2 new records" do
  #     expect { Recipient.import(data) }.to change(Recipient,:count).by(2)
  #     expect { Recipient.import(data) }.to change(Recipient,:count).by(2)
  #   end
  # end
end
