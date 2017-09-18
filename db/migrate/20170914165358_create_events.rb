class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.references :place, index: true, foreign_key: true
      t.integer :kind, default: 0
      t.datetime :start_time
      t.string :title
      t.integer :invites, array: true, default: []
      t.integer :author_id      

      t.timestamps
    end
  end
end
