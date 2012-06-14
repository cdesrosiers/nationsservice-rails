class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :country, default: ""
      t.string :state, default: ""
      t.string :city, default: ""

      t.timestamps
    end

    add_index :locations, :country
    add_index :locations, :state
    add_index :locations, :city
    add_index :locations, [:country, :state, :city], unique: true
  end
end
