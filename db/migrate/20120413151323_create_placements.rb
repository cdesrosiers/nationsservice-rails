class CreatePlacements < ActiveRecord::Migration
  def change
    create_table :placements do |t|
      t.integer :position_id
      t.integer :locale_id

      t.timestamps
    end
    
    add_index :placements, :position_id
    add_index :placements, :locale_id
    add_index :placements, [:position_id, :locale_id], unique: true
  end
end
