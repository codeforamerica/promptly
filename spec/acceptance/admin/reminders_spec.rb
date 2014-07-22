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

  scenario "creating a reminder should work" do
    sign_in @user
    @message = FactoryGirl.create :message, name: "hot snakes", organization_id: @user.organizations.first.id
    @group = FactoryGirl.create :group, organization_id: @user.organizations.first.id
    visit "/admin/organizations/#{@user.organizations.first.id}/reminders/new"
    choose 'message_id_1'
    check 'group_ids_'
    fill_in('Send date', :with => '01/01/2000')
    fill_in('Send time', :with => '12:00pm')
    click_button 'Schedule Reminder'
    expect(page).to have_content @group.name
    expect(page).to have_content @message.message_text
    expect(page).to have_content '01/01/2000'
    expect(page).to have_content '12:00pm'
    expect(page).to have_content 'confirm'
  end

  scenario "creating a new message should add it to the message list" do
    # sign_in @user
    # @count = Message.all.count
    # visit "/admin/organizations/#{@user.organizations.first.id}/reminders/new"
    # fill_in('message_name', :with => 'audit')
    # fill_in('Message text', :with => 'in progress')
    # click_link 'new-message-submit'
    # page.has_css?('reveal-modal-bg', :visible => false)
    # # expect(Message.all.count).to eq @count+1
    # expect(page).to have_content 'audit'
  end

  scenario "creating a new group should add it to the group list" do
    # sign_in @user
    # @count = Group.all.count
    # visit "/admin/organizations/#{@user.organizations.first.id}/reminders/new"
    # # click_link 'new_group_button'
    # fill_in('group_name', :with => 'unwound')
    # fill_in('recipient_phone', :with => '9999999999')
    # click_link 'groups-submit'
    # expect(Group.all.count).to eq @count+1
  end
end
