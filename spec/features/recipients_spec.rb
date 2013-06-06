# spec/features/recipients_spec.rb

require 'spec_helper'

describe "Recipients" do
  before :each do
    @report = FactoryGirl.create(:report, :humanname => "the test report")
    @user = FactoryGirl.create(:user)
    #sign in
    visit new_user_session_path
    fill_in "Email",    :with => @user.email
    fill_in "Password", :with => @user.password
    click_button "Sign in"
     @report = FactoryGirl.create(:report, :humanname => "the test report")
  end

  it "Adds a new recipient and displays the results" do
    visit recipients_path
    expect{
      click_link 'New recipient'
      fill_in 'recipient_phone', with: "9196361635"
      select @report.humanname, :from => "Available reports"
      select "Jan", :from => "notifications[send_date(2i)]"
      select "1", :from => "notifications[send_date(3i)]"
      select "2013", :from => "notifications[send_date(1i)]"
      click_button "Create Recipient"
    }.to change(Recipient,:count).by(1)
    page.should have_content "Recipient was successfully created."
    page.should have_content "9196361635"
  end
end