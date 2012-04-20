class AddOverviewToPositions < ActiveRecord::Migration
  def change
    add_column :positions, :overview, :string, limit: 1024
  end
end
