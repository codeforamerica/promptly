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
    
    if @organization.save
      redirect_to admin_organization_path(@organization)
    else
      render action: "edit", status: "unprocessable_entity"
    end
  end
end
