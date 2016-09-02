class CreateFavoriteLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :favorite_locations do |t|
      t.string :name, {null: false }
      t.string :address, {null: false }
      t.float  :lat, {null: false, precision: 10 }
      t.float  :lng, {null: false, precision: 10 }
      t.integer :user_id, {null: false }

      t.timestamps(null: false)
    end
  end
end
