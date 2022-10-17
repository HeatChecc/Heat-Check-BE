# frozen_string_literal: true

class CreateDishes < ActiveRecord::Migration[5.2]
  def change
    create_table :dishes do |t|
      t.string :name
      t.string :cuisine_type
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
