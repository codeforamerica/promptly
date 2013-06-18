class ChangeTypetoReportTypeinReports < ActiveRecord::Migration
  def up
  	add_column :reports, :report_type, :string
  end

  def down
  	remove_column :reports, :type
  end
end
