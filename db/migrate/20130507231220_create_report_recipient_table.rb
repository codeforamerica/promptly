class CreateReportRecipientTable < ActiveRecord::Migration
  def up
    create_table :recipients_reports, :id => false do |t|
      t.integer :recipient_id
      t.integer :report_id
    end
  end

  def down
  end
end
