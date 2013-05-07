class CreateRecipents < ActiveRecord::Migration
  def change
    create_table :recipents do |t|
      t.integer :phone
      t.integer :case
      t.boolean :active

      t.timestamps
    end
  end
end
