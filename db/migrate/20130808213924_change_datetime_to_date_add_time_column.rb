class ChangeDatetimeToDateAddTimeColumn < ActiveRecord::Migration
  def up
  	change_column :deliveries, :send_date, :date
  	add_column :deliveries, :send_time, :datetime
  end

  def down
  end
end
