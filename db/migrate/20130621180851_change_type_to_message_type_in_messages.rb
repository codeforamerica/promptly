class ChangeTypeToMessageTypeInMessages < ActiveRecord::Migration
  def up
  	remove_column :messages, :type
  	add_column :messages, :message_type, :string
  end

  def down
  end
end
