class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :report_id
      t.integer :recipient_id
      t.datetime :send_date

      t.timestamps
    end
  end
end
