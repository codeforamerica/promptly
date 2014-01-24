require_relative '../acceptance_helper'

feature "Conversations" do
  scenario "showing the page when not logged in" do
    visit "/admin/conversations"
    page.current_path.should == "/"
    page.should have_content "Promptly"
  end

  scenario "showing the page when logged in" do
    sign_in FactoryGirl.create :user
    visit "/admin/conversations"
    page.current_path.should == "/admin/conversations"
    page.should have_content "Conversations"
    page.should have_content "Responses"
    page.should have_content "Undelivered"
  end
end
