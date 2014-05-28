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

   scenario "creating a new user when not logged in" do
    visit "/admin/organizations/1/users/new"
    page.current_path.should == "/"
  end

  scenario "creating a new user" do
    sign_in FactoryGirl.create :user
    visit "/admin/users/new"
    page.should have_content
  end

  scenario "viewing the show page" do
    sign_in FactoryGirl.create :user
    visit "/admin/organizations/1/users/1"
    page.should have_content
  end
    
end
