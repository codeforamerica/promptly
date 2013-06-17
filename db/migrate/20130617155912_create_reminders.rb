class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.string :name
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :program_id
      t.integer :report_id
      t.integer :message_id

      t.timestamps
    end
  end
end
