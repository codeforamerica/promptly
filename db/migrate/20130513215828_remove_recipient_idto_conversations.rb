class RemoveRecipientIdtoConversations < ActiveRecord::Migration
  def up
  	remove_column :conversations, :recipient_id, :string
  end

  def down
  end
end
