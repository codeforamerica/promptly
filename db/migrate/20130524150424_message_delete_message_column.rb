class MessageDeleteMessageColumn < ActiveRecord::Migration
  def up
  	  	remove_column :messages, :message
  end

  def down
  end
end
