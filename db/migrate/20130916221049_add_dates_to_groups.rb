class AddDatesToGroups < ActiveRecord::Migration
  def change
  	add_column :groups,  :created_at, :datetime
  	add_column :groups,  :updated_at, :datetime
  end
end
