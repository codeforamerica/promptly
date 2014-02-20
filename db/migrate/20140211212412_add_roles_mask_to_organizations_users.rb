class AddRolesMaskToOrganizationsUsers < ActiveRecord::Migration
  def change
  	add_column :organizations_users, :roles_mask, :integer
  end
end
