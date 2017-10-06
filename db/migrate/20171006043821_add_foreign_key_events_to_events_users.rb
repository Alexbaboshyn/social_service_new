class AddForeignKeyEventsToEventsUsers < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :events_users, :events
  end
end
