class CreatePlaceUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :place_users do |t|
      t.integer :user_id, index: true, foreign_key: true
      t.integer :place_id, index: true, foreign_key: true
      t.integer :rating

      t.timestamps
    end
  end
end
