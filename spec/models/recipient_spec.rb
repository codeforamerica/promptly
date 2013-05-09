require 'spec_helper'


describe Recipient do
	before :each do
	    @recipient = Recipient.new(:phone => +19196361635, :case => 1234)
	end
  it "should have a phone number" do
    @recipient.phone.should_not be_nil
  end
end
