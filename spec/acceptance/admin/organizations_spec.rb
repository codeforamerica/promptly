require_relative '../acceptance_helper'

feature "Organizations" do
  scenario "should load the page" do
    visit "/admin/organizations"
    page.current_path.should == "/"
    page.should have_content "Organizations"
  end

  scenario "should load the creation page" do
    visit "/admin/conversations/new"
    page.current_path.should == "/admin/conversations/new"
    page.should have_content "Organizations"
  end
end
