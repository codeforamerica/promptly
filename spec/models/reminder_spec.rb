require 'spec_helper'

describe Reminder do
	it "has a valid factory" do
    FactoryGirl.create(:reminder).should be_valid
  end
end
