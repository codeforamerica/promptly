class AddBatchIdToConversations < ActiveRecord::Migration
  def change
  	add_column :conversations, :batch_id, :string
  end
end
