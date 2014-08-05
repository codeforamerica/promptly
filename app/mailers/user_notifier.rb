class UserNotifier < ActionMailer::Base
  default from: "promptly-admin@#{ENV['DOMAIN']}"

  def send_daily_import_log(user)
    @user = user
    user.each do |u|
      mail( :to => u.email,
      :subject => 'Import log for #{Date.today}' )
    end
  end

end