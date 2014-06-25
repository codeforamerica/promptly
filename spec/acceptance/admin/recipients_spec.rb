require_relative "../acceptance_helper.rb"

feature "Recipients" do
  before do
    @user = FactoryGirl.create :user_with_organization
    @user.organizations_user.first.update_attributes(roles_mask: 1)
  end

  scenario "viewing the index when not logged in" do
    visit "/admin/organizations/#{@user.organizations.first.id}/recipients"
    expect(page.current_path).to eq "/"
  end

  scenario "viewing the index page" do
    sign_in @user
    visit "/admin/organizations/#{@user.organizations.first.id}/recipients"
    expect(page).to have_content
  end

end
