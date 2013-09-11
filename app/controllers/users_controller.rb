class UsersController < ApplicationController
	before_filter :check_permissions, :only => [:index]

	def check_permissions
		authorize! :create, User
	end

	def index
		@users = User.all
	end
	
end