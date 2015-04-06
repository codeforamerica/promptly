class AddOrganizationIdToTables < ActiveRecord::Migration
  def change
  	add_column :reminders, :organization_id, :integer
  	add_column :messages, :organization_id, :integer
  	add_column :conversations, :organization_id, :integer
  	add_column :groups, :organization_id, :integer
  end
end
