class AdminController < ApplicationController
  before_filter :make_sure_someone_is_logged_in

  private

  def make_sure_someone_is_logged_in
    raise CanCan::AccessDenied.new("Not authorized!") if current_user.nil?
  end
end
