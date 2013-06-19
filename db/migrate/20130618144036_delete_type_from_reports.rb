class DeleteTypeFromReports < ActiveRecord::Migration
  def up
  	remove_column :reports, :type
  end

  def down
  end
end
