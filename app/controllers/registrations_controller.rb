class RegistrationsController < Devise::RegistrationsController
	before_filter :check_permissions, :only => [:new, :create, :cancel]
	skip_before_filter :require_no_authentication

	def check_permissions
		authorize! :create, User
	end
	
end