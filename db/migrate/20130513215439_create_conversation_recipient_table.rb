class CreateConversationRecipientTable < ActiveRecord::Migration
  def up
  	create_table :conversations_recipients, :id => false do |t|
      t.integer :recipient_id
      t.integer :conversation_id
    end
  end

  def down
  end
end
