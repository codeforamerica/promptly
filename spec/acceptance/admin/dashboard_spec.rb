require_relative '../acceptance_helper'

feature "Dashboard" do
  scenario "showing the page when not logged in" do
    visit "/admin"
    page.current_path.should == "/"
    page.should have_content "Promptly"
  end

  scenario "showing the page when logged in" do
    sign_in FactoryGirl.create :user
    visit "/admin"
    page.current_path.should == "/admin"
    page.should have_content "Schedule a reminder"
    page.should have_content "Upcoming reminders"
    page.should have_content "Sent reminders"
    page.should have_content "Responses"
    page.should have_content "Undelivered reminders"
  end
end
