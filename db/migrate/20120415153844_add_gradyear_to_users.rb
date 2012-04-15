class AddGradyearToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gradyear, :integer
  end
end
