class CreateMessagesRemindersTable < ActiveRecord::Migration
  def up
  	create_table :messages_reminders, :id => false do |t|
      t.integer :reminder_id
      t.integer :message_id
    end
  end

  def down
  end
end
