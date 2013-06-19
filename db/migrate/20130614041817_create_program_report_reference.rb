class CreateProgramReportReference < ActiveRecord::Migration
  def up
  	change_table :reports do |t|
  		t.remove :program_id
  		t.references :program
  	end
  end

  def down
  	change_table :reports do |t|
  		t.remove :program_id
  		t.integer :program_id
  	end
  end
end
