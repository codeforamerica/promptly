# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Landshark::Application.initialize!

Time::DATE_FORMATS[:date_format] = "%B %d %Y %H:%M"
