class CreateDeliveryTable < ActiveRecord::Migration
  def up
  	create_table :deliveries do |t|
      t.string :name
      t.datetime :send_date
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :recipient_id
      t.integer :reminder_id

      t.timestamps
	  end
  end

  def down
  end
end
