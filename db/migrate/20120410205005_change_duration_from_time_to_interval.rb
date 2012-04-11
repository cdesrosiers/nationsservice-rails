class ChangeDurationFromTimeToInterval < ActiveRecord::Migration
  def change
    change_column :positions, :duration, :interval
  end
end
