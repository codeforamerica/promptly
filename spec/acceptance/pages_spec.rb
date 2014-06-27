require_relative "./acceptance_helper"

feature "Pages" do
  before do
    @user = FactoryGirl.create :user_with_organization
    @user.organizations_user.first.update_attributes(roles_mask: 1)
  end

  scenario "the page shown after login should be a personalized dashboard" do
    sign_in @user
    visit "/"
    expect(page).to have_content "Welcome"
    expect(page).to have_content @user.organizations.first.name
  end

  scenario "the page should show the promptly landing page when noone is logged in" do
    visit "/"
    expect(page).to have_content "Craft a message"
  end
end

    
    
