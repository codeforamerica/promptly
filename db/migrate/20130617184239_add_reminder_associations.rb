class AddReminderAssociations < ActiveRecord::Migration
  def up
  	change_table :messages do |t|
  		t.integer :reminder_id
  		t.integer :report_id
  	end

  	change_table :reports do |t|
  		t.integer :reminder_id
  		t.integer :program_id
  	end

  	change_table :programs do |t|
  		t.integer :reminder_id
  	end

  end

  def down
  	change_table :messages do |t|
  		t.remove :reminder_id
  		t.remove :report_id
  	end

  	change_table :reports do |t|
  		t.remove :reminder_id
  		t.remove :program_id
  	end

  	change_table :programs do |t|
  		t.remove :reminder_id
  	end
  end
end