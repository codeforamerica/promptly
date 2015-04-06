require_relative '../acceptance_helper'

feature "Messages" do
  before do
    @user = FactoryGirl.create :user_with_organization
    @user.organizations_user.first.update_attributes(roles_mask: 1)
  end

  scenario "showing the page when not logged in" do
    visit "/admin/organizations/#{@user.organizations.first.id}/messages"
    expect(page.current_path).to eq "/"
    expect(page).to have_content "Promptly"
  end

  scenario "showing the page when logged in" do
    sign_in @user
    message = FactoryGirl.create :message, name: "Do What You Like", organization_id: @user.organizations.first.id
    visit "/admin/organizations/#{@user.organizations.first.id}/messages"
    expect(page.current_path).to eq "/admin/organizations/#{@user.organizations.first.id}/messages"
    expect(page).to have_content "Do What You Like"
    expect(page).to have_content message.name
  end

  scenario "the new page should work" do
    sign_in @user
    visit "/admin/organizations/#{@user.organizations.first.id}/messages/new"
  end

end
