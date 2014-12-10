class Admin::DashboardController < OrgController
  before_filter :authorize
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
	
  def index
    @this_org = Organization.find(@organization.id)
    @recipient = Recipient.all
    @recents = Conversation.organization(@organization.id).find(:all, :order => "date desc")
    @conversations = Conversation.organization(@organization.id).where("message_id is not null", :order => "date desc")
    @upcoming = Reminder.organization(@organization.id).upcoming
    @last_month = Conversation.organization(@organization.id).where("status =? and date >= ?", "sent", DateTime.now - 1.month ).count
    @this_year = Conversation.organization(@organization.id).where("status =? and date >= ?", "completed", "#{Time.now.year}0101").count
    @last_month_calls = Conversation.unique_calls_last_month(@this_org.phone_number)
    @calls = Conversation.organization(@organization.id).where("call_id is not null and message_id is null", :order => "date desc")
    @last_month == 0 ? @response_rate = 0 : @response_rate = ((Conversation.organization(@organization.id).unique_calls_last_month(@this_org.phone_number).count.to_f/2)/@last_month.to_f)*100
    @undelivered_rate = Conversation.organization(@organization.id).undelivered_month.count >0? ((Conversation.organization(@organization.id).month_calls.count.to_f/2)/Conversation.organization(@organization.id).undelivered_month.count.to_f)*100 : 0


    notifications_scope = Conversation.organization(@organization.id)
    if !params[:filter].nil? 
      notifications_scope = notifications_scope.like(params[:filter]) if !params[:filter].empty?
    end
    notifications_scope = notifications_scope.all_calls if params[:calls_check] == "1"
    notifications_scope = notifications_scope.undelivered if params[:undelivered_check] == "1"
    notifications_scope = notifications_scope.unsubscribed if params[:stop_check] == "1"
    notifications_scope = notifications_scope.all_sent if params[:messages_check] == "1"
    if params[:start_date] || params[:end_date]
      notifications_scope = notifications_scope.date_filter(start_date: params[:start_date], end_date: params[:end_date]) if !params[:start_date].empty? || !params[:end_date].empty?
    end
    @notifications = smart_listing_create(:notifications, notifications_scope, partial: "admin/dashboard/listing")

    respond_to do |format|
      format.html # index.html.erb
      format.json 
      format.js
    end
  end

  def authorize
    raise CanCan::AccessDenied unless can? :read, Reminder, @organization_user
  end
end
