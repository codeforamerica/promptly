# spec/requests/contacts_spec.rb

require 'spec_helper'

describe "Recipients" do
  it "Adds a new recipient and displays the results" do
    visit recipients_path
    expect{
      click_link 'New recipient'
      fill_in 'recipient_phone', with: "9196361635"
      select " ", :from => "Available reports"
      click_button "Create Recipient"
    }.to change(Recipient,:count).by(1)
    page.should have_content "Recipient was successfully created."
    page.should have_content "9196361635"
  end
end