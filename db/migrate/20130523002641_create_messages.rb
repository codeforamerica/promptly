class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :type
      t.text :message
      t.integer :report_id
      t.datetime :send_date

      t.timestamps
    end
  end
end
