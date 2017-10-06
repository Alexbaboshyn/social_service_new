class AddForeignKeyUsersToPlaceUsers < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :place_users, :users
  end
end
