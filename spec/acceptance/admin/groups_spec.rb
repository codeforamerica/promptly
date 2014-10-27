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
    expect(page).to have_content "CREATE GROUP"
  end

  scenario "should create a group" do
    sign_in @user
    @count = Group.all.count
    visit "/admin/organizations/#{@user.organizations.first.id}/groups/new"
    fill_in('group_name', :with => 'Hot Snakes')
    fill_in('group_description', :with => 'No Hands')
    fill_in('recipient_phone', :with => Faker::PhoneNumber.phone_number)
    click_button 'Create Group'
    expect(Group.all.count).to eq @count +1
  end

  scenario "index should show group name" do
    sign_in @user
    @group = FactoryGirl.create :group, organization_id: @user.organizations.first.id
    visit "/admin/organizations/#{@user.organizations.first.id}/groups"
    expect(page).to have_content "#{@group.name}"
  end

  scenario "should show a group" do
    sign_in @user
    group = FactoryGirl.create :group, name: "Shock G", organization_id: @user.organizations.first.id
    visit "/admin/organizations/#{@user.organizations.first.id}/groups/#{group.id}"
    expect(page).to have_content "Shock G"
    expect(page).to have_content "Group History"
  end    

  scenario "should show notification history" do
    sign_in @user
    @group = FactoryGirl.create :group, name: "Unwound", organization_id: @user.organizations.first.id
    @message = FactoryGirl.create :message
    @reminder = FactoryGirl.create :reminder_with_message_and_recipient, send_date: DateTime.now - 1.day
    @group.recipients << @reminder.recipient
    @reminder.groups << @group
    @conversation = FactoryGirl.create :conversation, message: @group.reminders.first.message.message_text, organization_id: @user.organizations.first.id, group_id: @group.id
    @conversation.recipients << @group.recipients
    visit "/admin/organizations/#{@user.organizations.first.id}/groups/#{@group.id}"
    expect(page).to have_content "#{@group.reminders.first.message.message_text}"
  end  

  scenario "should show upcoming notifications" do
    sign_in @user
    @group = FactoryGirl.create :group, name: "Unwound", organization_id: @user.organizations.first.id
    @message = FactoryGirl.create :message
    @reminder = FactoryGirl.create :reminder_with_message_and_recipient, send_date: DateTime.now + 1.day
    @group.recipients << @reminder.recipient
    @reminder.groups << @group
    visit "/admin/organizations/#{@user.organizations.first.id}/groups/#{@group.id}"
    expect(page).to have_content "#{@group.reminders.first.message.message_text}"
  end     
end
