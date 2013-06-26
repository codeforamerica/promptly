# spec/features/recipients_spec.rb

require 'spec_helper'

describe "Reminders" do
  before :each do
    @reminder = FactoryGirl.create(:reminder)
    @user = FactoryGirl.create(:user)
    #sign in
    visit new_user_session_path
    fill_in "Email",    :with => @user.email
    fill_in "Password", :with => @user.password
    click_button "Sign in"
  end

  it "add a new reminder" do
    visit reminders_path
    expect{
      click_link 'Create reminder'
      # save_and_open_page
      fill_in 'Name', with: @reminder.name
      # select @reminder.program.name, :from => "reminder_program_id"
      select @reminder.report.report_type, :from => "reminder_report_id"
      fill_in 'Text for this reminder', with: @reminder.name
      click_button "Create Reminder"
    }.to change(Reminder,:count).by(1)
  end

  # it "adds new reports" do
  #   visit new_reminder_path
  #   click_link 'Add report'
  #   # expect {
  #   last_nested_fields = all('.control-group').last
  #   within(last_nested_fields) do
  #     # fill_in 'Form name of this report', with: "test"
  #     page.should have_content 'Description of this report'
  #   end
  #     click_link 'Remove report'
  #     # click_button "Create Recipient"
  #     # }.to change(Report;:count).by(1)

  # end

  # it "removes reports" do
  #   visit new_reminder_path
  #   click_link 'Add report'
  #   page.has_field? 'Form name for this report'
  #   page.has_field? 'Description of this report'
  #   click_link 'Remove report'
  #   page.has_no_field? 'Form name for this report'
  #   page.has_no_field? 'Description of this report'
  # end

  # it "Adds a new reminder and displays the results" do
  #   visit reminders_path
  #   click_link "Create reminder"
  #   # expect{
  #   #   click_link 'New reminder'
  #   #   click_button "Create Recipient"
  #   # }.to change(Reminder,:count).by(1)
  #   # page.should have_content "Recipient was successfully created."
  #   # page.should have_content "9196361635"
  # end
end