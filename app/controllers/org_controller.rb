class OrgController < AdminController
	layout "organization"

  before_filter :get_organization

  def get_organization
    @organization = Organization.find(params[:organization_id])
  end

end
