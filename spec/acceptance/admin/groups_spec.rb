require_relative '../acceptance_helper'

feature "Groups" do
  before do
    @user = FactoryGirl.create :user
  end

  scenario "index page should require login" do
    visit "/admin/groups"
    page.current_path.should == "/"
  end

  scenario "root should load" do
    sign_in @user
    visit "/admin/groups"
    page.current_path.should == "/admin/groups"
    page.should have_content "New group"
  end

  scenario "should show a group" do
    sign_in @user
    group = FactoryGirl.create :group, name: "Shock G"
    visit "/admin/groups/#{group.id}"
    page.should have_content "Shock G"
    page.should have_content "Group History"
  end    
end
