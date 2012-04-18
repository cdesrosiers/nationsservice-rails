class AddIndexesToInstitutions < ActiveRecord::Migration
  def change
    add_index :institutions, [:name, :state], unique: true
    add_index :campus, [:name], unique: true
  end
end
