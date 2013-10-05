# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
if Rails.env.production? && ENV['SECRET_TOKEN'].blank?
	raise 'The SECRET_TOKEN environment variable is not set.\n
	To generate it, run "rake secret", then set it with "heroku config:set SECRET_TOKEN=the_token_you_generated"'
end

Promptly::Application.config.secret_token = ENV['SECRET_TOKEN'] || '7f5655b8052331139a499caeccf25a82f0cc6e1cb297cee25d9fb5666412272074e5484454e4a3b2dd49db5ff44ed079ebc277d6f02d686b5e9359aaf800f6d0'
