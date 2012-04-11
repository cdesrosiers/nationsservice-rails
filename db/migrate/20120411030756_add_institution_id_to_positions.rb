class AddInstitutionIdToPositions < ActiveRecord::Migration
  def change
    add_column :positions, :institution_id, :integer
    add_index :positions, :institution_id
  end
end
