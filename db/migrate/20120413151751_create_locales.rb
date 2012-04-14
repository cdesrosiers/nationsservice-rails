class CreateLocales < ActiveRecord::Migration
  def change
    create_table :locales do |t|
      t.string :country
      t.string :province
      t.string :city

      t.timestamps
    end
    
    add_index :locales, :country
    add_index :locales, :province
    add_index :locales, :city
  end
end
