# spec/features/programs_spec.rb

require 'spec_helper'

describe "Programs" do
  before :each do
     FactoryGirl.create(:report)
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
  it "Adds a new program and displays the results" do
    visit programs_path
    expect{
      click_link 'New Program'
      fill_in 'Name', with: "Calfresh"
      fill_in 'Description', with: "this is just a test"
      click_button "Create Program"
    }.to change(Program,:count).by(1)
    page.should have_content "Program was successfully created."
    page.should have_content "Calfresh"
  end
end