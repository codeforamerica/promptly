class CreateProgramsRecipientsTable < ActiveRecord::Migration
  def up
  	  create_table :programs_recipients, :id => false do |t|
      t.integer :recipient_id
      t.integer :program_id
    end
  end

  def down
  end
end
