class ConversationRemoveBatchIdAddGroupId < ActiveRecord::Migration
  def up
    add_column :conversations, :group_id, :string
    remove_column :conversations, :batch_id
  end

  def down
  end
end
