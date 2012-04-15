class DropLocationFromPositions < ActiveRecord::Migration
  def change
    remove_column :positions, :location_city
    remove_column :positions, :location_state
    remove_column :positions, :location_country
  end
end
