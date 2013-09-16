class GroupsController < ApplicationController
  # GET /Groups
  # GET /Groups.json
  def index
    @groups = Group.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
    end
  end

  # GET /Groups/1
  # GET /Groups/1.json
  def show
    @group = Group.find(params[:id])

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
    phones = params[:recipient][:phone]
    phones.split("\r\n").each do |phone_number|
    binding.pry
    	Recipient.where(phone: phone_number).first_or_create
	  end

    respond_to do |format|
      if @group.save
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
      if @group.update_attributes(params[:Group])
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
      format.html { redirect_to Groups_url }
      format.json { head :no_content }
    end
  end
end
