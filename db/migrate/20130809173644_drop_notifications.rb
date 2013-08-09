class DropNotifications < ActiveRecord::Migration
  def up
  	drop_table :notifications
  end

  def down
  end
end
