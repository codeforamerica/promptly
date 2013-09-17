class CreateGroups < ActiveRecord::Migration
  def up
  	create_table :groups do |t|
      t.string :name
      t.string :group_name_id
      t.text :description
      t.boolean :editable
      t.boolean :active
    end
  end

  def down
  end
end
