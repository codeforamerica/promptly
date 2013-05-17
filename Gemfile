source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'friendly_id'
gem 'rack-cors', :require => 'rack/cors'
gem 'twilio-ruby'
gem 'unicorn'
gem 'delayed_job_active_record'

group :development do
  gem 'pry'
end

group :development, :test do
  gem 'sqlite3', '1.3.5'
  gem 'rspec-rails', '2.11.0'
  gem 'sms-spec'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.2.5'
  gem 'compass-rails'
  gem 'bootstrap-sass', '~> 2.1.0'
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.2.3'
  gem 'font-awesome-sass-rails'
end


gem 'jquery-rails', '2.0.2'

group :test do
  gem 'capybara', '1.1.2'
end

group :production do
  gem 'pg', '0.12.2'
end
