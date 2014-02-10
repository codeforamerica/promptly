require 'spec_helper'

describe User do
  before :each do
    @user = FactoryGirl.create :user
  end
    
  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end

  it "is invalid without an email" do
    FactoryGirl.build(:user, email: nil).should_not be_valid
  end

  it "should have many organizations" do
    lambda { @user.organizations }.should_not raise_error
  end
end
