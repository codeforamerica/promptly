class UserNotifier < ActionMailer::Base
  default from: "promptly-admin@#{ENV['DOMAIN']}"

  def send_daily_import_log(total, new_notifications, new_groups, user)
    @user = user
    @total = total
    @new_notifications = new_notifications
    @new_groups = new_groups
    binding.pry
    mail( :to => @user.email,
    :subject => 'Daily Promptly import log' )
  end

end