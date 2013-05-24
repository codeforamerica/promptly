class ChangeMessageColumntoMessageText < ActiveRecord::Migration
  def up
  	add_column :messages, :message_text, :string
  end

  def down
  	remove_column :messages, :message
  end
end
