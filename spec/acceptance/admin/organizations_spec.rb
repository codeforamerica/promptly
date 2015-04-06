require_relative '../acceptance_helper'

feature "Organizations" do
  before do
    @user = FactoryGirl.create :user_with_organization
    @user.organizations_user.first.update_attributes(roles_mask: 1)
    @super = FactoryGirl.create :admin_with_organization
    @super.update_attributes(roles_mask: 1)
  end

  it "should load the dashboard when logged in" do
    sign_in @user
    visit "/admin/organizations/#{@user.organizations.first.id}/"
    expect(page.current_path).to eq "/admin/organizations/#{@user.organizations.first.id}/dashboard"
    expect(page).to have_content "Dashboard"
  end

  scenario "should load the creation page" do
    sign_in @user
    visit "/admin/organizations/#{@user.organizations.first.id}/organizations/new"
    expect(page.current_path).to eq "/admin/organizations/#{@user.organizations.first.id}/organizations/new"
    expect(page).to have_content "New Organization"
  end

  scenario "should show roles" do
    sign_in @user
    visit "/admin/organizations/#{@user.organizations.first.id}/edit"
    expect(page).to have_content "admin"
  end

  scenario "should create a new organization" do
    sign_in @user
    visit "/admin/organizations/new"
    expect(page.current_path).to eq "/admin/organizations/new"
    expect(page).to have_content "New Organization"
  end

  scenario "should load all organizations" do
    sign_in @user
    visit "/admin/organizations"
    expect(page.current_path).to eq "/admin/organizations"
    expect(page).to have_content "Your Organizations"
  end

  scenario "should create a new organization POST #create " do
    sign_in @super
    @count = Organization.all.count
    visit "/admin/organizations/new"
    fill_in('Name', :with => 'hot snakes')
    fill_in('Phone number', :with => '9999999999')
    check('organizations_user_user_ids_1')  
    select('admin', :from => 'organizations_user_1[roles_mask]')
    @super.organizations << Organization.last
    click_button 'Create Organization'
    expect(Organization.all.count).to eq @count+1
    expect(page).to have_content "hot snakes"
  end

  scenario "should delete organization" do
    sign_in @super
    @count = Organization.all.count
    @organization = Organization.first
    visit "/admin/organizations/#{@organization.id}/edit"
    click_link 'Delete this organization'
    expect(Organization.all.count).to eq @count-1
  end

  scenario "should not show the user button if not an admin" do
    sign_in @user
    @user.organizations_user.first.update_attributes(roles_mask: 2)
    @organization = Organization.first
    visit "/admin/organizations/#{@organization.id}/"
    expect(page).to have_no_selector(:link_or_button, 'Users')
  end

  scenario "should  show the user button a super user" do
    sign_in @super
    @organization = Organization.first
    visit "/admin/organizations/#{@organization.id}/"
    expect(page).to have_selector(:link_or_button, 'Users')
  end

end
