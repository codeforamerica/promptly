require_relative '../acceptance_helper'

feature "SuperDashboard" do
  before do
    @user = FactoryGirl.create :user_with_organization
    @user.organizations_user.first.update_attributes(roles_mask: 1)
  end

  scenario "showing the page when not logged in" do
    visit "/admin"
    expect(page.current_path).to eq "/"
    expect(page).to have_content "Promptly"
  end

  scenario "showing the page when logged in" do
    sign_in @user
    visit "/admin"
    expect(page.current_path).to eq "/admin"
    expect(page).to have_content "ALL ORGANIZATIONS"
    expect(page).to have_content "DASHBOARD"
  end
end
