class UserNotifier < ActionMailer::Base
  default from: "promptly-admin@#{ENV['DOMAIN']}"

  def send_daily_import_log(total, new_notifications, new_groups, user)
    @user = user
    @total = total
    @new_notifications = new_notifications
    @new_groups = new_groups
    user.each do |u|
      Rails.logger.info u.first
      if ! u.empty?
        mail( :to => u.first.email,
        :subject => 'Daily Promptly import log' )
      end
    end
  end

end