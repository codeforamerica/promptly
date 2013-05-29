class AddReportIdtoPrograms < ActiveRecord::Migration
  def up
  	add_column :programs, :report_id, :integer
  end

  def down
  end
end
