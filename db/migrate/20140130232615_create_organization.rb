class CreateOrganization < ActiveRecord::Migration
  def change
    create_table :organizations do |table|
      table.string :name, :null => false
      table.timestamps
    end    
  end
end
