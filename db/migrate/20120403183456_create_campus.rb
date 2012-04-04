class CreateCampus < ActiveRecord::Migration
  def change
    create_table :campus do |t|
      t.string :name
      t.integer :institution_id

      t.timestamps
    end
    add_index :campus, [:institution_id]
    add_index :campus, [:name]
  end
end
