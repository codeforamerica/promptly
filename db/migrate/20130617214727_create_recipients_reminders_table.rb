class CreateRecipientsRemindersTable < ActiveRecord::Migration
  def up
  	create_table :recipients_reminders, :id => false do |t|
      t.integer :reminder_id
      t.integer :recipient_id
     end
  end

  def down
  end
end
