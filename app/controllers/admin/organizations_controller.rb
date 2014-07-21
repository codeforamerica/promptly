class Admin::OrganizationsController < AdminController
  
  def index
    @organizations = Organization.all
  end
 
  def new
  	@organization = Organization.new
  end

  def show
    @organization = Organization.find(params[:id])
    redirect_to(admin_organization_dashboard_path(@organization.id))
  end

  def edit
    @organization = Organization.find(params[:id])
  end
 
  def destroy
    authorize
  	@organization = Organization.find(params[:id])

    if @organization.destroy
      redirect_to action: "index", notice: "Organization successfully deleted."
    else
      redirect_to admin_organization_path(@organization)
    end    
  end
 
  def create
    authorize
    @organization = Organization.new(params[:organization])
    if params[:organization][:phone_number].length <12
      @phone = "+1" + params[:organization][:phone_number]
      @organization.update_attributes(:phone_number => @phone)
    else
      @organization.update_attributes(:phone_number => params[:organization][:phone_number])
    end
    if @organization.save
      Organization.save_org_users(@organization.id, params[:organizations_user][:user_ids], params[:organizations_user])
      redirect_to admin_organization_path(@organization) 
    else
      render action: "new", status: "unprocessable_entity"
    end
  end

  def update
    authorize
    @organization = Organization.update(params[:id], params[:organization])
    if params[:organization][:phone_number].length <12 && params[:organization][:phone_number].length >0
      @phone = "+1" + params[:organization][:phone_number]
      @organization.update_attributes(:phone_number => @phone)
    else
      @organization.update_attributes(:phone_number => params[:organization][:phone_number])
    end
    
    if @organization.save
      Organization.save_org_users(@organization.id, params[:organizations_user][:user_ids], params[:organizations_user])
      redirect_to admin_organization_path(@organization)
    else
      render action: "edit", status: "unprocessable_entity"
    end
  end

  def authorize
    if !@current_user.is_super? 
      raise CanCan::AccessDenied 
    end
  end

end
