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
    params[:organizations_user][:user_ids].each do |user_id|
      if user_id[1] == "1"
        @organization_users = OrganizationsUser.where(:organization_id => params[:id], :user_id => user_id[0]).first_or_create
        @org_role = params[:organizations_user]["#{user_id[0]}"]
        @organization_users.update_attributes(:roles_mask => OrganizationsUser.mask_for(@org_role[:roles]))
        @organization_users.save
      end
    end
 
    if @organization.save
      redirect_to admin_organization_path(@organization)
    else
      render action: "new", status: "unprocessable_entity"
    end
  end

  def update
    authorize
    @organization = Organization.update(params[:id], params[:organization])
    if params[:organization][:phone_number].length <12
      @phone = "+1" + params[:organization][:phone_number]
      @organization.update_attributes(:phone_number => @phone)
    else
      @organization.update_attributes(:phone_number => params[:organization][:phone_number])
    end
    params[:organizations_user][:user_ids].each do |user_id|
      @organization_users
      if user_id[1] == "1"
        @organization_users = OrganizationsUser.where(:organization_id => params[:id], :user_id => user_id[0]).first_or_create
        @org_role = params[:organizations_user]["#{user_id[0]}"]
        @organization_users.update_attributes(:roles_mask => OrganizationsUser.mask_for(@org_role[:roles]))
        @organization_users.save
      else
        if OrganizationsUser.exists?(:organization_id => params[:id], :user_id => user_id[0])
          OrganizationsUser.find(params[:id], user_id[0]).delete
        end
      end
    end
    
    if @organization.save
      redirect_to admin_organization_path(@organization)
    else
      render action: "edit", status: "unprocessable_entity"
    end
  end

  def authorize
    raise CanCan::AccessDenied unless @current_user.is_super?
  end

end
