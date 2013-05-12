require 'spec_helper'

describe Recipient do
	before :each do
	    @recipient = Recipient.new(:phone => +19196361635, :case => 1234)
	end
  subject { @recipient }

  it { should respond_to(:phone) }
  it { should respond_to(:case) }

  it { should be_valid }

  describe "when phone is not present" do
    before { @recipient.phone = " " }
    it { should_not be_valid }
  end
end
