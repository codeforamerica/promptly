class GroupsController < ApplicationController
  # GET /Groups
  # GET /Groups.json
  load_and_authorize_resource
  def index
    @groups = Group.all
    binding.pry

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
    end
  end

  # GET /Groups/1
  # GET /Groups/1.json
  def show
    @group = Group.find(params[:id])
    @group_reminders = @group.reminders

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

    respond_to do |format|
      if @group.save
		    phones = params[:recipient][:phone]
		    add_phone_numbers_to_group(phones, @group)
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /Groups/1
  # PUT /Groups/1.json
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
        phones = params[:group][:phone]
        add_phone_numbers_to_group(phones, @group)
      if @group.update_attributes(name: params[:group][:name], description: params[:group][:description])
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
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
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end

  def add_phone_numbers_to_group(phone_numbers, the_group)
  	phones_to_group = []
	  phone_numbers.split("\r\n").each do |phone_number|
    	recipient = Recipient.where(phone: phone_number).first_or_create
    	recipient.save
    	unless recipient == ""
    	  phones_to_group << recipient.id
	    end
	  end
	  the_group.recipient_ids = phones_to_group
  end
end
