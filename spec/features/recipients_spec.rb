# spec/features/recipients_spec.rb

require 'spec_helper'

describe "Recipients" do
  before :each do
    @reminder = FactoryGirl.create(:reminder)
    @user = FactoryGirl.create(:user)
    #sign in
    visit new_user_session_path
    fill_in "Email",    :with => @user.email
    fill_in "Password", :with => @user.password
    click_button "Sign in"
  end

  it "Adds a new recipient and displays the results" do
    visit recipients_path
    expect{
      click_link 'New recipient'
      fill_in 'recipient_phone', with: "9196361635"
      select @reminder.name, :from => "Available reminders"
      click_button "Create Recipient"
    }.to change(Recipient,:count).by(1)
    page.should have_content "Recipient was successfully created."
    page.should have_content "9196361635"
  end
end