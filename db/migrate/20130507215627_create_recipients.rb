class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.integer :phone
      t.integer :case
      t.boolean :active

      t.timestamps
    end
  end
end
