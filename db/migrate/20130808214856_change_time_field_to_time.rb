class ChangeTimeFieldToTime < ActiveRecord::Migration
  def up
  	change_column :deliveries, :send_time, :time
  end

  def down
  end
end
