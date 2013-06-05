# spec/features/reports_spec.rb

require 'spec_helper'

describe "Reports" do
  before :each do
     FactoryGirl.create(:program)
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