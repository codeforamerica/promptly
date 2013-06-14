class CreateReportMessageReference < ActiveRecord::Migration
  def up
  	change_table :messages do |t|
  		t.remove :report_id
  		t.references :report
  	end
  end

  def down
  	change_table :messages do |t|
  		t.remove :report_id
  		t.integer :report_id
  	end
  end
end
