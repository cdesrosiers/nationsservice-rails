class AddStrrepToLocales < ActiveRecord::Migration
  def change
    add_column :locales, :strrep, :string
  end
end
