class CreatePlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :places do |t|
      t.float :lat
      t.float :lng
      t.string :name
      t.string :place_id
      t.string :tags, array: true, default: []
      t.string :name
      t.string :city
      t.float :overall_rating, precision: 2, scale: 1

      t.timestamps
    end
  end
end
