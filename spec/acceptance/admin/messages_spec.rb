require_relative '../acceptance_helper'

feature "Messages" do
  before do
    @user = FactoryGirl.create :user
  end

  scenario "showing the page when not logged in" do
    visit "/admin/messages"
    page.current_path.should == "/"
    page.should have_content "Promptly"
  end

  scenario "showing the page when logged in" do
    sign_in @user
    message = FactoryGirl.create :message, name: "Do What You Like"
    visit "/admin/messages"
    page.current_path.should == "/admin/messages"
    page.should have_content "Do What You Like"
    page.should have_content message.name
  end

  scenario "the new page should work" do
    sign_in @user
    visit "/admin/messages/new"
  end

end
