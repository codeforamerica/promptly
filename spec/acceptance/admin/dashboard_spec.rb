require_relative '../acceptance_helper'

feature "Dashboard" do
  scenario "showing the page when not logged in" do
    visit "/admin"
    page.current_path.should == "/"
    page.should have_content "Promptly"
  end
end
