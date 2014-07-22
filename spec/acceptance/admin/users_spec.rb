require_relative "../acceptance_helper.rb"

feature "Users" do
  before do
    @user = FactoryGirl.create :user_with_organization
    @user.organizations_user.first.update_attributes(roles_mask: 1)
  end

  scenario "viewing the index when not logged in" do
    visit "/admin/organizations/#{@user.organizations.first.id}/users"
    expect(page.current_path).to eq "/"
  end

  scenario "viewing the index page" do
    sign_in @user
    visit "/admin/organizations/#{@user.organizations.first.id}/users"
    expect(page).to have_content
  end

   scenario "creating a new user when not logged in" do
    visit "/admin/organizations/#{@user.organizations.first.id}/users/new"
    expect(page.current_path).to eq "/"
  end

  scenario "creating a new user" do
    sign_in @user
    visit "/admin/organizations/#{@user.organizations.first.id}/users/new"
    expect(page).to have_content
  end

  scenario "viewing the show page" do
    sign_in @user
    visit "/admin/organizations/#{@user.organizations.first.id}/users/1"
    expect(page).to have_content
  end

  scenario "should update roles" do
    @user2 = FactoryGirl.create :user_with_organization
    @user2.organizations_user.first.update_attributes(roles_mask: 1)
    sign_in @user
    visit "/admin/organizations/#{@user.organizations.first.id}/users/#{@user2.id}/edit"
    select('guest', :from => 'organizations_user_2[roles_mask]')
    click_button 'UPDATE'
    visit "/admin/organizations/#{@user.organizations.first.id}/users/#{@user2.id}/edit"
    expect( find(:css, 'select').value ).to eq('guest')
  end
    
end
