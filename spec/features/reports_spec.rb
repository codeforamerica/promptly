# spec/features/reports_spec.rb

require 'spec_helper'

describe "Reports" do
  before :each do
     FactoryGirl.create(:program)
<<<<<<< HEAD
     @user = FactoryGirl.create(:user)
     #sign in
    visit new_user_session_path
    fill_in "Email",    :with => @user.email
    fill_in "Password", :with => @user.password
    click_button "Sign in"
=======
>>>>>>> 7b8ab7086104eb504f49dfc3d8c2f9b614f5351c
  end
  it "Adds a new report and displays the results" do
    visit reports_path
    expect{
      click_link 'New Report'
      fill_in 'Form name of this report', with: "Test report"
      fill_in 'report_humanname', with: "this is just a test"
      select "Calfresh", :from => "report_program_id"
      click_button "Create Report"
    }.to change(Report,:count).by(1)
    page.should have_content "Report was successfully created."
    page.should have_content "Test report"
  end
end