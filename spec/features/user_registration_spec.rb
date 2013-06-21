require "spec_helper"

describe "user registration" do
	before :each do
     @user = FactoryGirl.create(:user)
  end
  it "allows new users to register with an email address and password" do
    visit new_user_registration_path

    fill_in "Email",                 :with => @user.email
    fill_in "Password",              :with => @user.password
    fill_in "Password confirmation", :with => @user.password
    select "admin",                  :from => "user_roles"

    click_button "Sign up"

    # page.should have_content("Welcome! You have signed up successfully.")
  end
end