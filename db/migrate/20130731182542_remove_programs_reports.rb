class RemoveProgramsReports < ActiveRecord::Migration
  def up
  	drop_table :programs
  	drop_table :reports
  	remove_column :notifications, :report_id
  end

  def down
  end
end
