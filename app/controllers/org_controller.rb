class OrgController < AdminController
	layout "organization"

  before_filter :get_organization, :get_organization_user

  def get_organization
    if current_user.is_super?
      params[:organization_id]? params[:organization_id] : 1
      @organization = Organization.find(params[:organization_id])
    else 
      @organization = Organization.find(params[:organization_id])
    end
  end

  def get_organization_user 
  	@user ||= @current_user 
  	@organization_user = OrganizationsUser.where(user_id: @user.id).where(organization_id: params[:organization_id]).first 
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, params[:organization_id])
  end

end

