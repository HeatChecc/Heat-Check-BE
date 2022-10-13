class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :image_url
      t.string :address
      t.string :phone
      t.float :rating
      t.string :price

      t.timestamps
    end
  end
end
