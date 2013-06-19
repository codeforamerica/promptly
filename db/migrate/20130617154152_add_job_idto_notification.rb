class AddJobIdtoNotification < ActiveRecord::Migration
  def up
  	add_column :notifications, :job_id, :integer
  end

  def down
  end
end
