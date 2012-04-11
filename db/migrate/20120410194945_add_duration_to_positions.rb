class AddDurationToPositions < ActiveRecord::Migration
  def change
    add_column :positions, :duration, :time
    add_index :positions, :duration
  end
end
