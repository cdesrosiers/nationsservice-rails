class AddCampusIdToPositions < ActiveRecord::Migration
  def change
    add_column :positions, :campus_id, :integer
  end
end
