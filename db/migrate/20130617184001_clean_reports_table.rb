class CleanReportsTable < ActiveRecord::Migration
  def up
  	change_table :reports do |t|
  		t.remove "program_id"
  		t.remove "report_type"

  	# Original table:
	  # create_table "reports", :force => true do |t|
	  #   t.string   "type"
	  #   t.text     "humanname"
	  #   t.datetime "created_at",  :null => false
	  #   t.datetime "updated_at",  :null => false
	  #   t.string   "report_type"
	  #   t.integer  "program_id"
	  # end


 	end
  end

  def down
  	change_table :reports do |t|
  		t.integer "program_id"
  		t.string "report_type"
  	end
  end
end