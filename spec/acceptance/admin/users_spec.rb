require_relative "../acceptance_helper.rb"

feature "Users" do

  scenario "viewing the index when not logged in" do
    visit "/admin/users"
    page.current_path.should == "/"
  end

  scenario "viewing the index page" do
    sign_in FactoryGirl.create :user
    visit "/admin/users"
    page.should have_content
  end

end
