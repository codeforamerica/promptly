class MessageChangeMessageColumn < ActiveRecord::Migration
  def up
  	add_column :messages, :messagetext, :text
  end

  def down
  	remove_column :messages, :message
  end
end
