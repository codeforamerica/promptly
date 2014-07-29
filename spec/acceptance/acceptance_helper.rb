require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "steak"

# Put your acceptance spec helpers inside /spec/acceptance/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

def sign_in(user)
  visit "/users/sign_in"
  fill_in "user_email",    with: user.email
  fill_in "user_password", with: user.password
  click_button "SIGN IN"
end
