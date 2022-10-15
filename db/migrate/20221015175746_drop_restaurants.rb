class DropRestaurants < ActiveRecord::Migration[5.2]
  def change
    drop_table :restaurants, force: :cascade
  end
end
