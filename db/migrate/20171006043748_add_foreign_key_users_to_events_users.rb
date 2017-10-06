class AddForeignKeyUsersToEventsUsers < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :events_users, :users
  end
end
