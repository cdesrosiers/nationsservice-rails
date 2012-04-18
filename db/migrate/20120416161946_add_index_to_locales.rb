class AddIndexToLocales < ActiveRecord::Migration
  def change
    add_index :locales, [:country, :province, :city], unique: true
  end
end
