class PagesController < ApplicationController

	layout "splash"

	def splash
    if user_signed_in?
      if @current_user.is_super?
        @organizations = Organization.all
        @organization = @organizations.first
        # render file: "layouts/organization"
        render "admin/superdashboard/index", layout: "application"
      else
        @organizations = current_user.organizations
        render "landing_page", layout: "application"
      end
    end
	end  
end
