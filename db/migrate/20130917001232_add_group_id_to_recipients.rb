class AddGroupIdToRecipients < ActiveRecord::Migration
  def change
  	add_column :recipients, :group_id, :string

  end
end
