class DropTestingTables < ActiveRecord::Migration
  def up
  end

  def down
  	drop_table :grandparents
  	drop_table :parents
  	drop_table :children

  	remove_index :children, :name => "index_children_on_parent_id"
  	remove_index :parents, :name => "index_parents_on_grandparent_id"
  end
end
