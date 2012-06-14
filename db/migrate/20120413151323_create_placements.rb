class CreatePlacements < ActiveRecord::Migration
  def change
    create_table :placements do |t|
      t.integer :placeable_id
      t.string :placeable_type
      t.integer :location_id
      t.timestamps
    end
    
    add_index :placements, :placeable_id
    add_index :placements, :location_id
    add_index :placements, [:placeable_id, :placeable_type, :location_id],
      unique: true, name: 'uniqueness_index'
  end
end
