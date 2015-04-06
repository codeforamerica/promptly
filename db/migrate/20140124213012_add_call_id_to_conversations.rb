class AddCallIdToConversations < ActiveRecord::Migration
  def change
  	add_column :conversations, :call_id, :string
  end
end
