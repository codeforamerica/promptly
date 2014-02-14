require_relative "./acceptance_helper"

feature "Pages" do
  scenario "the page shown after login should be a personalized dashboard" do
    @organization = FactoryGirl.create :organization    
    @user = FactoryGirl.create :user
    @organization.users << @user
    @organization.save.should == true

    sign_in @user
    visit "/"

    page.should have_content "Welcome!"
    page.should have_content @organization.name
  end

  scenario "the page should show the promptly landing page when noone is logged in" do
    visit "/"
    page.should have_content "Craft a message"
  end
end

    
    
