require "spec_helper"

describe Organization do
  before :each do
    @organization = FactoryGirl.create :organization
  end

  describe "creation" do
    it "should be a valid model" do
      lambda { Organization.new }.should_not raise_error
    end
  end

  it "should have a users association" do
    lambda { @organization.users }.should_not raise_error
  end

  it "should take another user" do
    @user = FactoryGirl.create :user
    @organization.users << @user
    @organization.save.should == true    
  end
end
