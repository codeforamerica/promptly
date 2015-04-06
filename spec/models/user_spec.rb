require 'spec_helper'

describe User do
  before :each do
    @user = FactoryGirl.create :user
  end
    
  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  it "is invalid without an email" do
    expect(FactoryGirl.build(:user, email: nil)).to_not be_valid
  end

  it "should have many organizations" do
    expect(lambda { @user.organizations }).to_not raise_error
  end
end
