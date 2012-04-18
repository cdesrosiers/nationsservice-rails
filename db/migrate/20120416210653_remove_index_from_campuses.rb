class RemoveIndexFromCampuses < ActiveRecord::Migration
 def change
   remove_index :campus, :name
 end
end
