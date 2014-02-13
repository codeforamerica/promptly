require_relative '../acceptance_helper'

feature "Organizations" do
  before do
    @user = FactoryGirl.create :user
  end

  it "should load the page when logged in" do
    sign_in @user
    visit "/admin/organizations"
    page.current_path.should == "/admin/organizations"
    page.should have_content "Organizations"
  end

  scenario "should load the creation page" do
    sign_in @user
    visit "/admin/organizations/new"
    page.current_path.should == "/admin/organizations/new"
    page.should have_content "New Organization"
  end
end
