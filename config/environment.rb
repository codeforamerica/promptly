# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Landshark::Application.initialize!

Date::DATE_FORMATS.merge!(:default => "%m/%d/%Y")

Time::DATE_FORMATS[:date_format] = lambda { |time| time.strftime("%B %d, %Y %l:%M%p %Z") }
Time::DATE_FORMATS[:time_only] = lambda { |time| time.strftime("%l:%M%p %Z") }
Time::DATE_FORMATS[:date_only] = lambda { |time| time.strftime("%B %d, %Y") }
Time::DATE_FORMATS[:input_format] = "%yy %mm %dd %H:%M"
