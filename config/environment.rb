# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Storyboard::Application.initialize!

Time::DATE_FORMATS[:date] = "%A %d %B"
Date::DATE_FORMATS[:date] = "%A %d %B"