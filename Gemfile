source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'friendly_id'
gem 'rack-cors', :require => 'rack/cors'
gem 'twilio-ruby'
gem 'unicorn'
gem 'delayed_job_active_record'
gem 'bootstrap-sass', '~> 2.1.0'
gem 'roo'
gem 'devise'
gem 'cancan'
gem 'foreman'

group :development do
  gem 'pry'
  gem 'pry-nav'
end

group :development, :test do
  gem 'sqlite3', '1.3.5'
  gem 'rspec-rails'
  gem 'sms-spec'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.2.5'
  gem 'compass-rails'
  gem 'uglifier', '1.2.3'
  gem 'font-awesome-sass-rails'
  gem 'coffee-rails'
end

gem 'jquery-rails', '2.0.2'

group :test do
  gem "factory_girl_rails"
  gem "capybara"
  gem "guard-rspec"
  gem 'shoulda-matchers'
  gem 'rake'
end

group :production do
  gem 'pg', '0.12.2'
end
