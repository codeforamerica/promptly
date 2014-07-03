require "spec_helper"

describe Organization do
  before :each do
    @organization = FactoryGirl.create :organization
  end

  describe "creation" do
    it "should be a valid model" do
      expect(lambda { Organization.new }).not_to raise_error
    end
  end

  it "should have a users association" do
    expect(lambda { @organization.users }).not_to raise_error
  end

  it "should take another user" do
    @user = FactoryGirl.create :user
    @organization.users << @user
    expect(@organization.save).to eq true    
  end

  describe "save_org_users" do
    it "should save users to organizations_user" do
      @user = FactoryGirl.create :user
      test_array = []
      test_array << @user.id
      Organization.save_org_users(test_array)
    end
  end
end
