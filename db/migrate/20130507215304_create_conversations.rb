class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.timestamp :date
      t.text :message

      t.timestamps
    end
  end
end
