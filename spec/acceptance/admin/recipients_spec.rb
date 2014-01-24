require_relative "../acceptance_helper.rb"

feature "Recipients" do

  scenario "viewing the index when not logged in" do
    visit "/admin/recipients"
    page.current_path.should == "/"
  end

  scenario "viewing the index page" do
    sign_in FactoryGirl.create :user
    visit "/admin/recipients"
    page.should have_content
  end

end
