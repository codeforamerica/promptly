class Admin::RemindersController < OrgController
  include Helper
  prepend_before_filter :auth_create, :only => :create
  before_filter :patch_batch_id
  load_and_authorize_resource :only => [:show,:new,:destroy]

  def index
    @groups = Reminder.accessible_by(current_ability).organization(params[:organization_id]).grouped_reminders
    @sent = Conversation.accessible_by(current_ability).organization(params[:organization_id]).grouped_sent_conversations

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reminders }
    end
  end

  def show
    @reminders = Reminder.where("send_date >=?", DateTime.now)
    @total_count = 0
    @reminders.each do |reminder|
      reminder.groups.each do |group|
        @total_count += group.recipients.count
      end
    end
  end

  def new
    @reminder = Reminder.new
    @message = @reminder.build_message
    @recipients = @reminder.build_recipient
    @group = Group.new
    @messages_search = Message.accessible_by(current_ability).organization(params[:organization_id]).all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reminder }
    end
  end

  # GET /deliveries/1/edit
  def edit
    @reminders = Reminder.find(params[:id])
  end

  def confirm
    @reminder = Reminder.new(params[:reminder])


    # @individual_recipients = parse_phone_numbers(params[:individual_recipients])
    # If they didn't create a new message,
    # get the one from the radio button and add it to the reminder
    
    params[:reminder][:message_id] = params[:message_id] if params[:reminder][:message_id].nil?  
    @groups = Group.where(:id => params[:group_ids])
    
    if params[:group_ids].nil? 
      unless params[:group].nil?
        new_group = Group.where(name: params[:group][:name]).first_or_create
        recipients = group_to_recipient_ids(new_group.id)
      end
    else 
      unless params[:group].nil?
        if params[:group][:name] != ""
          new_group = Group.where(name: params[:group][:name]).first_or_create
          params[:group_ids] << new_group.id
        end
      end
      recipients = group_to_recipient_ids(params[:group_ids])
    end
    if params[:reminder][:send_date].length > 11
      @reminder.update_attributes(message_id: params[:reminder][:message_id], :send_date => params[:reminder][:send_date])
    elsif params[:reminder][:send_date].nil? || params[:reminder][:send_date] == ""
      @reminder
    else
      @reminder.update_attributes(message_id: params[:reminder][:message_id], :send_date => DateTime.strptime(params[:reminder][:send_date], "%m/%d/%Y"))

    end
    if !@reminder.valid?
      render :action => 'new'
    end
  end

  def create
    @reminder = Reminder.new(params[:reminder])
    params[:reminder][:group_ids].each do |group|
      Reminder.create_new_reminders(Message.find(params[:reminder][:message_id]), params[:reminder][:send_date], send_time: params[:reminder][:send_time], group_id: params[:reminder][:group_ids], organization: @organization.id)
    end
    @reminder.save
    respond_to do |format|
      format.html { redirect_to [:admin, @organization, @reminder], notice: 'Reminder was successfully created.' }
      format.json { render json: @reminder, status: :created, location: @reminder }
    end
  end

  def update
    @reminder = Reminder.first_or_create("id=?", params[:id])
    @organization = Organization.find(params[:organization_id])
    params[:reminder][:group_ids].each do |group|
      Reminder.create_new_reminders(Message.find(params[:reminder][:message_id]), params[:reminder][:send_date], send_time: params[:reminder][:send_time], group_id: params[:reminder][:group_ids], organization: @organization.id)
    end
    @reminder.save
    respond_to do |format|
      format.html { redirect_to admin_organization_reminders_url, notice: 'Reminder was successfully created.' }
      format.json { head :no_content }
    end
  end

  def destroy
    @reminders = Reminder.find(params[:id])
    # @reminders.each do |reminder|
      destroy_delayed_job_by_job_id(@reminder.job_id)     
      @reminder.destroy
    # end

    respond_to do |format|
      format.html { redirect_to [:admin, @organization, @reminder], notice: 'Reminder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    Reminder.import(params[:file], params[:reminder])
    redirect_to organization_reminders_url, notice: "Reminder created."
  end

  private
  
  def patch_batch_id
    # TODO: Nuke references to batch_id in favor of the usual id.
    params[:batch_id] = params[:id]
  end

  def auth_create
    can? :manage, Organization, :organization_id => @organization.id
  end
end
