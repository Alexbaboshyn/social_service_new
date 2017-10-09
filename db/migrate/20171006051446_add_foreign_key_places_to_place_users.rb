class AddForeignKeyPlacesToPlaceUsers < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :place_users, :places
  end
end
