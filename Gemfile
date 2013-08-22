source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'friendly_id'
gem 'rack-cors', :require => 'rack/cors'
gem 'twilio-ruby'
gem 'twilio'
gem 'unicorn'
gem 'delayed_job_active_record'
gem 'roo'
gem 'devise'
gem 'cancan'
gem 'foreman'
gem 'jquery-rails', '2.0.2'
gem 'jquery-ui-rails'
gem 'role_model'
gem 'pg'
gem 'simple_form'
gem 'bootstrap-datepicker-rails'
gem 'whenever'

group :development, :test do
  gem 'pry'
  gem 'pry-nav'
  gem 'sqlite3', '1.3.5'
  gem 'rspec-rails'
  gem 'dotenv-rails'
  gem 'database_cleaner'
  gem 'daemons'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'uglifier', '1.2.3'
  gem 'font-awesome-sass-rails'
  gem 'coffee-rails'
  gem 'sass'
  gem 'sass-rails'
  gem 'compass'
  gem 'compass-rails'
  gem 'bootstrap-sass'
end

group :test do
  gem "factory_girl_rails"
  gem "capybara"
  gem "launchy"
  gem "guard-rspec"
  gem 'shoulda-matchers'
  gem 'rake'
end

# Only try to install these gems on staging/prod servers
if ENV['RACK_ENV'] == 'staging' or ENV['RACK_ENV'] == 'production'
  group :production do
    # gem 'tiny_tds'
    # gem 'activerecord-sqlserver-adapter'
    # gem 'therubyracer'
  end
end