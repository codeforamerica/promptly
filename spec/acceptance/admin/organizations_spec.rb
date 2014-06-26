require_relative '../acceptance_helper'

feature "Organizations" do
  before do
    @user = FactoryGirl.create :user_with_organization
    @user.organizations_user.first.update_attributes(roles_mask: 1)
  end

  it "should load the page when logged in" do
    sign_in @user
    visit "/admin/organizations/#{@user.organizations.first.id}/organizations"
    expect(page.current_path).to eq "/admin/organizations/#{@user.organizations.first.id}/organizations"
    expect(page).to have_content "Organizations"
  end

  scenario "should load the creation page" do
    sign_in @user
    visit "/admin/organizations/#{@user.organizations.first.id}/organizations/new"
    expect(page.current_path).to eq "/admin/organizations/#{@user.organizations.first.id}/organizations/new"
    expect(page).to have_content "New Organization"
  end
end
