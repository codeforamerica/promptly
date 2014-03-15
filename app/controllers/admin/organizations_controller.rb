class Admin::OrganizationsController < AdminController

  def index
    @organizations = Organization.all
  end
 
  def new
  	@organization = Organization.new
  end

  def show
    @organization = Organization.find(params[:id])
  end

  def edit
    @organization = Organization.find(params[:id])
  end
 
  def destroy
  	@organization = Organization.find(params[:id])

    if @organization.destroy
      redirect_to action: "index", notice: "Organization successfully deleted."
    else
      redirect_to admin_organization_path(@organization)
    end    
  end
 
  def create
    @organization = Organization.new(params[:organization])

 
    if @organization.save
      redirect_to admin_organization_path(@organization)
    else
      render action: "new", status: "unprocessable_entity"
    end
  end

  def update
    @organization = Organization.update(params[:id], params[:organization])
    @organization.users = User.find(params[:user_ids])
    binding.pry
    params[:user_ids].each do |user_id|
      @organization_users = OrganizationsUser.find(params[:id], user_id)
      @organization_users.update_attributes(:roles_mask => OrganizationsUser.mask_for(params[:roles]))
    end
    
    if @organization.save
      redirect_to admin_organization_path(@organization)
    else
      render action: "edit", status: "unprocessable_entity"
    end
  end
end
