class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :name
      t.string :description
      t.string :location_city
      t.string :location_state
      t.string :location_country
      t.date :deadline
      t.string :logo_path
      t.integer :position_type

      t.timestamps
    end
  end
end
