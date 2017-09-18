class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.integer :gender, default: 0
      t.datetime :birthday
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
