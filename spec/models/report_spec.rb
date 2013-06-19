require 'spec_helper'

describe Report do
	it "has a valid factory" do
    FactoryGirl.create(:report).should be_valid
  end
end
