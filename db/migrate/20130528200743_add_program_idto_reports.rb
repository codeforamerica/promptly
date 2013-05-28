class AddProgramIdtoReports < ActiveRecord::Migration
  def up
  	add_column :reports, :program_id, :integer
  end

  def down
  end
end
