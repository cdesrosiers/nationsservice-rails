class AddInstitutionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :institution_id, :integer
    add_index :users, :institution_id
    
    add_column :users, :campus_id, :integer
    add_index :users, :campus_id
  end
end
