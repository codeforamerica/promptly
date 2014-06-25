require_relative '../acceptance_helper'

feature "Groups" do
  before do
    @user = FactoryGirl.create :user_with_organization
    @user.organizations_user.first.update_attributes(roles_mask: 1)
  end

  scenario "index page should require login" do
    visit "/admin/organizations/#{@user.organizations.first.id}/groups"
    expect(page.current_path).to eq("/")
  end

  scenario "root should load" do
    sign_in @user
    visit "/admin/organizations/#{@user.organizations.first.id}/groups"
    expect(page.current_path).to eq("/admin/organizations/#{@user.organizations.first.id}/groups")
    expect(page).to have_content "New group"
  end

  scenario "should show a group" do
    sign_in @user
    group = FactoryGirl.create :group, name: "Shock G", organization_id: @user.organizations.first.id
    visit "/admin/organizations/#{@user.organizations.first.id}/groups/#{group.id}"
    expect(page).to have_content "Shock G"
    expect(page).to have_content "Group History"
  end    
end
