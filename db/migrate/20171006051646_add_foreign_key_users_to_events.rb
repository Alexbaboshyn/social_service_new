class AddForeignKeyUsersToEvents < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :events, :users, column: :author_id
  end
end
