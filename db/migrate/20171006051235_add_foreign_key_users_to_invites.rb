class AddForeignKeyUsersToInvites < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :invites, :users
  end
end
