class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :name
      t.string :description
      t.date :deadline
      t.integer :poster_id
      t.integer :position_type, limit: 1
      t.integer :duration, limit: 1
      t.string :overview, limit: 2047

      t.timestamps
    end
  end
end
