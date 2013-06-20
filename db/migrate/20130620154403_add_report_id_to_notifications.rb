class AddReportIdToNotifications < ActiveRecord::Migration
  def change
  	add_column :notifications, :report_id, :integer
  end
end
