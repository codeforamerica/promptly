source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'friendly_id'
gem 'rack-cors', :require => 'rack/cors'
gem 'twilio-ruby'
gem 'twilio'
gem 'delayed_job_active_record'
gem 'roo'
gem 'devise'
gem 'cancan'
gem 'role_model'
gem 'simple_form'
gem 'whenever'
gem 'phony_rails'
gem 'json'
gem 'rake'
gem 'daemons'
gem 'pg'
gem 'unicorn'
gem 'foreman'
gem 'composite_primary_keys'
gem 'browser-timezone-rails'
gem 'newrelic_rpm'

group :development do
  gem 'pry'
  gem 'pry-nav'
  gem 'dotenv-rails'
  gem 'database_cleaner'
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
  gem 'jquery-datatables-rails', git: 'git://github.com/rweng/jquery-datatables-rails.git'
  gem 'bootstrap-datepicker-rails'
  gem 'jquery-rails', '2.0.2'
  gem 'jquery-ui-rails'
end

group :test do
  gem "faker"
  gem "steak"
  gem "factory_girl_rails"
  gem "capybara"
  gem "launchy"
  gem "guard-rspec"
  gem 'shoulda-matchers'
  gem 'rspec-rails'
  gem 'simplecov'
end

# Only try to install these gems on staging/prod servers
group :production do
  gem 'tiny_tds'
  # Installing adapter from GH source because because need a recent fix to use
  # Devise on SQL server: https://github.com/rails-sqlserver/activerecord-sqlserver-adapter/pull/262
  gem 'activerecord-sqlserver-adapter', git: 'git://github.com/rails-sqlserver/activerecord-sqlserver-adapter.git'
  gem 'therubyracer'
end
