class AddToFromConversations < ActiveRecord::Migration
  def change
  	add_column :conversations, :to_number, :string
  	add_column :conversations, :from_number, :string
  end
end
