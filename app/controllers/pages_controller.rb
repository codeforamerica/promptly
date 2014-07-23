class PagesController < ApplicationController
	def home
    if user_signed_in?
      if @current_user.is_super?
        @organizations = Organization.all
        @organization = @organizations.first
        redirect_to admin_dashboard_path
      else
        @organizations = current_user.organizations
        @organization = @organizations.first
        redirect_to admin_organizations_path
      end
    else
      render 'layouts/home', layout: "home"
    end
	end  
end
