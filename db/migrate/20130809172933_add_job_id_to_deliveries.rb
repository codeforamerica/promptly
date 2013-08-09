class AddJobIdToDeliveries < ActiveRecord::Migration
  def change
  	add_column :deliveries,  :job_id, :integer
  end
end
