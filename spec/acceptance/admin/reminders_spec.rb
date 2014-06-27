require_relative '../acceptance_helper'

feature "Reminders" do
  before do
    @user = FactoryGirl.create :user_with_organization
    @user.organizations_user.first.update_attributes(roles_mask: 1)
  end

  scenario "should redirect home when not logged in" do
    visit "/admin/organizations/#{@user.organizations.first.id}/reminders"
    expect(page).to have_content "Promptly"
    expect(page.current_path).to eq("/")
  end

  scenario "should show the page when logged in as an admin" do
    sign_in @user
    visit "/admin/organizations/#{@user.organizations.first.id}/reminders"
    expect(page).to have_content "Promptly"
    expect(page.current_path).to eq("/admin/organizations/#{@user.organizations.first.id}/reminders")
  end

  scenario "viewing a reminder should work" do
    sign_in @user
    reminder = FactoryGirl.create :reminder
    visit "/admin/organizations/#{@user.organizations.first.id}/reminders/#{reminder.id}"
    expect(page).to have_content
  end
end
