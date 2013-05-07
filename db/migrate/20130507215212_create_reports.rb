class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :type
      t.text :humanname

      t.timestamps
    end
  end
end
