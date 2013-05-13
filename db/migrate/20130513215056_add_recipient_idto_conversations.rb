class AddRecipientIdtoConversations < ActiveRecord::Migration
  def up
  	add_column :conversations, :recipient_id, :string
  end

  def down
  end
end
