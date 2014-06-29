# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Promptly::Application.initialize!

Date::DATE_FORMATS.merge!(:default => "%m/%d/%Y")

Time::DATE_FORMATS[:date_format] = lambda { |time| time.strftime("%B %d, %Y %l:%M%p %Z") }
Time::DATE_FORMATS[:time_only] = lambda { |time| time.strftime("%l:%M%p %Z") }
Time::DATE_FORMATS[:date_only] = lambda { |time| time.strftime("%B %d, %Y") }
Time::DATE_FORMATS[:input_format] = "%yy %mm %dd %H:%M"

ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['SENDGRID_USERNAME'],
  :password       => ENV['SENDGRID_PASSWORD'],
  :domain         => 'heroku.com',
  :enable_starttls_auto => true
}
