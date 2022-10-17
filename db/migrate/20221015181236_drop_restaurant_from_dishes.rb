# frozen_string_literal: true

class DropRestaurantFromDishes < ActiveRecord::Migration[5.2]
  def change
    remove_column :dishes, :restaurant_id
  end
end
