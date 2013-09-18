class ApplicationController < ActionController::Base

  helper :all

  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
def after_sign_in_path_for(resource)
    sign_in_url = url_for(:action => 'new', :controller => 'sessions', :only_path => false, :protocol => 'http')
    if request.referer == sign_in_url
      return dashboard_path
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end
end
