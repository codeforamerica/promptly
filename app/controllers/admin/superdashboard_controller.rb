class Admin::SuperdashboardController < AdminController
  # load_and_authorize_resource
  
  def index
    @recipient = Recipient.all
    @recents = Conversation.find(:all, :order => "date desc")
    @conversations = Conversation.where("message_id is not null", :order => "date desc")
    @upcoming = Reminder.upcoming
    @last_month = Conversation.where("status =? and date >= ?", "sent", DateTime.now - 1.month ).count
    @this_year = Conversation.where("status =? and date >= ?", "completed", "#{Time.now.year}0101").count
    @calls = Conversation.where("call_id is not null and message_id is null", :order => "date desc")
    @last_month == 0 ? @response_rate = 0 : @response_rate = ((Conversation.month_calls.count.to_f/2)/@last_month.to_f)*100
    @undelivered_rate = Conversation.undelivered_month.count >0? (Conversation.undelivered_month.count.to_f/@last_month.to_f)*100 : 0
  end

  def show_users
    @users = User.all
  end

  def edit_user
    @user = User.find(params[:id])
  end

  def update_user
    @user = User.find(params[:id])
    if params[:user][:password].blank?
      [:password,:password_confirmation,:current_password].collect{|p| params[:user].delete(p) }
    end
    account_update_params = params[:user]
     # required for settings form to submit when password is left blank
    if account_update_params[:password].blank?
      account_update_params.delete("password")
      account_update_params.delete("password_confirmation")
    end
    if @current_user.id == @user.id
      @bypass_flag = true
    else
      @bypass_flag = false
    end

    respond_to do |format|
      if @user.errors[:base].empty? and @user.update_attributes(params[:user])
        if @bypass_flag == true
          sign_in(@user, :bypass => true)
        end
          format.json { render :json => @user.to_json, :status => 200 }
          format.xml  { head :ok }
          format.html { redirect_to admin_superdashboard_show_users_path(1), notice: 'User account has been updated' }
      else
        format.json { render :text => "Could not update user", :status => :unprocessable_entity } #placeholder
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        format.html { render :text => @user.errors.full_messages.join('<br/>'), :status => :unprocessable_entity }
      end
    end
  end
end
