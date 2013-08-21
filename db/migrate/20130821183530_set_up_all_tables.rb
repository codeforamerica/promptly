class SetUpAllTables < ActiveRecord::Migration
  def up
  	create_table :conversations do |t|
  		t.datetime :date
    	t.text     :message
    	t.datetime :created_at, :null => false
	    t.datetime :updated_at, :null => false
	    t.string   :to_number
	    t.string   :from_number
	    t.string   :message_id
  	end

  	create_table :messages do |t|
	    t.string   :name
	    t.datetime :created_at,   :null => false
	    t.datetime :updated_at,   :null => false
	    t.string   :message_text
	    t.text     :description
	  end

	  create_table :reminders do |t|
	    t.string   :name
	    t.datetime :send_date
	    t.datetime :created_at,   :null => false
	    t.datetime :updated_at,   :null => false
	    t.integer  :recipient_id
	    t.integer  :message_id
	    t.string   :batch_id
	    t.time     :send_time
	    t.integer  :job_id
	  end

	  create_table :recipients do |t|
	    t.string   :phone
	    t.datetime :created_at, :null => false
	    t.datetime :updated_at, :null => false
	    t.string   :name
	  end
  end

  def down
  end
end
