class ChangeDurationToIntInPositions < ActiveRecord::Migration
  def change
    remove_column :positions, :duration
    add_column :positions, :duration, :integer, limit: 1
  end
end
