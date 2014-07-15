require "spec_helper"

describe Organization do
  before :each do
    @organization = FactoryGirl.create :organization
  end

  describe "creation" do
    it "expect be a valid model" do
      expect(lambda { Organization.new }).not_to raise_error
    end
  end

  it "expect to have a users association" do
    expect(lambda { @organization.users }).not_to raise_error
  end

  it "expect to take another user" do
    @user = FactoryGirl.create :user
    @organization.users << @user
    expect(@organization.save).to eq true    
  end

  describe "save_org_users" do
    it "expect to save users to organizations_user" do
      @user = FactoryGirl.create :user
      test_hash = {"organizations_user" =>
        {"user_ids"=>{"1"=>"1", "2"=>"0"},
         "1"=>{"roles_mask"=>"admin"},
         "2"=>{"roles_mask"=>""}}}
      Organization.save_org_users(@organization.id, test_hash["organizations_user"]["user_ids"], test_hash["organizations_user"])
    end
  end
end
