require_relative '../acceptance_helper'

feature "Reminders" do
  before do
    @user = FactoryGirl.create :user
  end

  scenario "should redirect home when not logged in" do
    visit "/admin/reminders"
    page.should have_content "Promptly"
    page.current_path.should == "/"
  end

  scenario "should show the page when logged in as an admin" do
    sign_in @user
    visit "/admin/reminders"
    page.should have_content "Promptly"
    page.current_path.should == "/admin/reminders"
  end

  scenario "viewing a reminder should work" do
    reminder = FactoryGirl.create :reminder
    visit "/admin/reminders/#{reminder.id}"
    page.should have_content
  end
end
