class AddPostedByToPositions < ActiveRecord::Migration
  def change
    add_column :positions, :posted_by, :integer
    add_index :positions, :posted_by
  end
end
