class GroupsRecipients < ActiveRecord::Migration
  def up
  	create_table :groups_recipients, :id => false do |t|
		  t.integer :group_id, :null => false
		  t.integer :recipient_id, :null => false
		end

	# Adding the index can massively speed up join tables. Don't use the
	# unique if you allow duplicates.
	add_index(:groups_recipients, [:group_id, :recipient_id], :unique => true)
  end

  def down
  end
end
