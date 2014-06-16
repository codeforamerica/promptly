class Admin::UsersController < OrgController
# from http://www.tonyamoyal.com/2010/09/29/rails-authentication-with-devise-and-cancan-part-2-restful-resources-for-administrators/
  before_filter :get_user, :only => [:index,:new,:edit]
  before_filter :authenticate_user!, :only => [:new, :edit, :show, :update, :create]
  before_filter :get_particular_user
  load_and_authorize_resource :only => [:show,:new,:destroy,:edit,:update]
 
  # GET /users
  # GET /users.xml                                                
  # GET /users.json                                       HTML and AJAX
  #-----------------------------------------------------------------------
  def index
    @users = User.accessible_by(current_ability, :index).limit(20)
    respond_to do |format|
      format.json { render :json => @users }
      format.xml  { render :xml => @users }
      format.html
    end
  end
 
  # GET /users/new
  # GET /users/new.xml                                            
  # GET /users/new.json                                    HTML AND AJAX
  #-------------------------------------------------------------------
  def new
  	@user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end
 
  # GET /users/1
  # GET /users/1.xml                                                       
  # GET /users/1.json                                     HTML AND AJAX
  #-------------------------------------------------------------------
  def show
    @org_role = OrganizationsUser.where("user_id = ? and organization_id = ?", @user.id, @organization.id).first.roles.first
    respond_to do |format|
      format.json { render :json => @user }
      format.xml  { render :xml => @user }
      format.html      
    end
 
  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
  end
 
  # GET /users/1/edit                                                      
  # GET /users/1/edit.xml                                                      
  # GET /users/1/edit.json                                HTML AND AJAX
  #-------------------------------------------------------------------
  def edit
    respond_to do |format|
      format.json { render :json => @user }   
      format.xml  { render :xml => @user }
      format.html
    end
 
  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
  end
 
  # DELETE /users/1     
  # DELETE /users/1.xml
  # DELETE /users/1.json                                  HTML AND AJAX
  #-------------------------------------------------------------------
  def destroy
  	@user = User.find(params[:id])
    @user.destroy
 
    respond_to do |format|
      flash[:notice] = "Account has been destroyed"
      format.html { redirect_to :action => :index }
    end
 
  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
  end
 
  # POST /users
  # POST /users.xml         
  # POST /users.json                                      HTML AND AJAX
  #-----------------------------------------------------------------
  def create
    @user = User.new(params[:user])
    if @user.save
      @organization_user = OrganizationsUser.create(
        user_id: @user.id,
        organization_id: params[:organization_id],
        roles_mask: 1) 
      puts "Roles mask: #{@user.roles_mask}"
      if @organization_user.save  
        respond_to do |format|
          flash[:notice] = "Account has been created"
          format.json { render :json => @user.to_json, :status => 200 }
          format.xml  { head :ok }
        format.html { redirect_to :action => :index }
        end
      else
        respond_to do |format|
          format.json { render :text => "Could not create organization user", :status => :unprocessable_entity } 
          format.html { render :text => @organization_user.errors.full_messages.join('<br/>'), :status => :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.json { render :text => "Could not create user", :status => :unprocessable_entity } # placeholder
        format.xml  { head :ok }
        format.html { render :text => @user.errors.full_messages.join('<br/>'), :status => :unprocessable_entity }
      end
    end
  end

   def update
    if params[:user][:password].blank?
      [:password,:password_confirmation,:current_password].collect{|p| params[:user].delete(p) }
    else
      @user.errors[:base] << "The password you entered is incorrect" unless @user.valid_password?(params[:user][:current_password])
    end
 
    respond_to do |format|
      if @user.errors[:base].empty? and @user.update_attributes(params[:user])
        flash[:notice] = "Your account has been updated"
        format.json { render :json => @user.to_json, :status => 200 }
        format.xml  { head :ok }
        format.html { render :action => :edit }
      else
        format.json { render :text => "Could not update user", :status => :unprocessable_entity } #placeholder
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        format.html { render :text => @user.errors.full_messages.join('<br/>'), :status => :unprocessable_entity }
      end
    end
 
  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:js, :xml, :html)
  end

  # Get roles accessible by the current user
  #----------------------------------------------------
  def accessible_roles
    @accessible_roles = Role.accessible_by(current_ability,:read)
  end
 
  # Make the current user object available to views
  #----------------------------------------
  def get_user
    @current_user = current_user
  end

  def get_particular_user
    puts "#{params}"
    if params[:id]
      @user = User.find(params[:id])
    end
  end

end
