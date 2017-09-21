class CreateInvites < ActiveRecord::Migration[5.0]
  def change
    create_table :invites do |t|
      t.integer :event_id, index: true, foreign_key: true
      t.integer :user_id, index: true, foreign_key: true

      t.timestamps
    end
  end
end
