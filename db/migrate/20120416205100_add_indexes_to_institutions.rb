class AddIndexesToInstitutions < ActiveRecord::Migration
  def change
    add_index :institutions, [:name, :state], unique: true
  end
end
