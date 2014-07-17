class Admin::MessagesController < OrgController
  load_and_authorize_resource
  
  def index
  	@messages = Message.accessible_by(current_ability).organization(params[:organization_id]).all
    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  def show
    @message = Message.find(params[:id])

  end

  def new
    @message = Message.new
    @message.reminders.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  def edit
    @message = Message.find(params[:id])
  end

  def create
    @message = Message.new(params[:message])
    @message.organization_id = @organization.id
    # binding.pry
    respond_to do |format|
      if @message.save
        # binding.pry
        format.js
        format.html { redirect_to [:admin, @organization, @message], notice: 'Message was successfully created.' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
        format.js 
      end
    end
  end

  def update
    @message = Message.find(params[:id])
    @message.organization_id = @organization.id

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to [:admin, @organization, @message], notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to admin_organization_messages_url(@organization) }
      format.json { head :no_content }
    end
  end
end
