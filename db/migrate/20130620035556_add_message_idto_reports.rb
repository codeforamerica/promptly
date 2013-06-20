class AddMessageIdtoReports < ActiveRecord::Migration
  def up
  	add_column :reports, :message_id, :integer
  end

  def down
  end
end
