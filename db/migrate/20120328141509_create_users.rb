class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :gradyear
      t.timestamps
    end

    add_index :users, :name
    add_index :users, :email, unique: true
    add_index :users, :gradyear
  end
end
