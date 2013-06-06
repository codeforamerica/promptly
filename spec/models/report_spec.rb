require 'spec_helper'

describe Report do
	it "has a valid factory" do
    FactoryGirl.create(:report).should be_valid
  end
  it "has many recipients" do
    should have_and_belong_to_many(:recipients)
  end
end
