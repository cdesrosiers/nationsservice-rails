class CreateInstitutions < ActiveRecord::Migration
  def change
    create_table :institutions do |t|
      t.string :name
      t.string :state

      t.timestamps
    end
    add_index :institutions, [:state]
  end
end
