class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :gradyear
      t.timestamps
    end
  end
end
