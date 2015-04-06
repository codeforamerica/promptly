class Admin::GroupsController < OrgController
  # GET /Groups
  # GET /Groups.json
  load_and_authorize_resource
  
  def index
    @groups = Group.accessible_by(current_ability).organization(params[:organization_id]).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
      format.js
    end
  end

  # GET /Groups/1
  # GET /Groups/1.json
  def show
    @group = Group.accessible_by(current_ability).organization(params[:organization_id]).find(params[:id])
    @group_reminders = @group.reminders
    @group_recipients = @group.recipients
    @group_conversations =[]
    @group_recipients.each do |recipient|
      if recipient.conversations != []
        @group_conversations << recipient.conversations.where(organization_id: params[:organization_id], group_id: @group.id.to_s)
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  # GET /Groups/new
  # GET /Groups/new.json
  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group }
    end
  end

  # GET /Groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /Groups
  # POST /Groups.json
  def create
    @group = Group.new(params[:group])
    @group.group_name_id = params[:group][:name].downcase.tr(' ', '_')
    @group.organization_id = @organization.id

    respond_to do |format|
      if @group.save
		    phones = params[:recipient][:phone]
		    Group.add_phone_numbers_to_group(phones, @group)
        format.js
        format.html { redirect_to [:admin, @organization, @group], notice: 'Group was successfully created.' }
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /Groups/1
  # PUT /Groups/1.json
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
        phones = params[:group][:phone]
        Group.add_phone_numbers_to_group(phones, @group)
      if @group.update_attributes(name: params[:group][:name], description: params[:group][:description])
        format.html { redirect_to [:admin, @organization, @group], notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Groups/1
  # DELETE /Groups/1.json
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to admin_organization_groups_path(@organization) }
      format.json { head :no_content }
    end
  end

end
