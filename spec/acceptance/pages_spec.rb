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

  scenario "the page shown after superadmin login should be the super dashboard" do
    @super = FactoryGirl.create :admin_with_organization
    @super.organizations_user.first.update_attributes(roles_mask: 1)
    sign_in @super
    visit "/"
    expect(page).to have_content "DASHBOARD ALL ORGANIZATIONS"
    expect(page).to have_content @super.organizations.first.name
  end

  scenario "the page shown after regular admin login should be the first organization dashboard" do
    sign_in @user
    visit "/"
    expect(page).to have_no_content "ALL ORGANIZATIONS"
    expect(page).to have_content "Your organizations"
  end

end

    
    
