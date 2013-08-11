# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Landshark::Application.initialize!

Time::DATE_FORMATS[:date_format] = lambda { |time| time.localtime.strftime("%B %d, %Y %l:%M%p %Z") }
Time::DATE_FORMATS[:input_format] = "%yy %mm %dd %H:%M"
