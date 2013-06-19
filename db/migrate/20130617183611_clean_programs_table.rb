class CleanProgramsTable < ActiveRecord::Migration
  def up
  	change_table :programs do |t|
  		t.remove "report_id"


	# Original table
	#  create_table "programs", :force => true do |t|
    #  	 t.string   "name"
    #    t.text     "description"
    #    t.datetime "created_at",  :null => false
  	#    t.datetime "updated_at",  :null => false
	#    t.integer  "report_id"
  	#  end


 	end
  end

  def down
  	change_table :programs do |t|
  		t.integer "report_id"
  	end
  end
end