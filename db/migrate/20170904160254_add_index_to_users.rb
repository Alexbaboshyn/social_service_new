class AddIndexToUsers < ActiveRecord::Migration[5.0]
  def up
      add_earthdistance_index :users
    end

    def down
      remove_earthdistance_index :users
    end
end
