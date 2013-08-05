class AddBatchIDtoDeliveries < ActiveRecord::Migration
  def up
  	add_column :deliveries, :batch_id, :integer
  end

  def down
  end
end
