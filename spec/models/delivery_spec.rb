require 'spec_helper'

describe Delivery do
	it "has a valid factory" do
    FactoryGirl.create(:delivery).should be_valid
  end
end
