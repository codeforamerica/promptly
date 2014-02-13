class PagesController < ApplicationController

	layout "splash"

	def splash
    if user_signed_in?
      @organizations = current_user.organizations
      render "landing_page", layout: "application"
    end
	end
	
  def hsa
  end

  def documents
  end
  
end
