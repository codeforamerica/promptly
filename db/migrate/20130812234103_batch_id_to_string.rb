class BatchIdToString < ActiveRecord::Migration
  def up
  	change_column :deliveries, :batch_id, :string
  end

  def down
  end
end
