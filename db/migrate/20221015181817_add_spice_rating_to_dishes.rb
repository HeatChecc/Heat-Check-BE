# frozen_string_literal: true

class AddSpiceRatingToDishes < ActiveRecord::Migration[5.2]
  def change
    add_column :dishes, :spice_rating, :integer
  end
end
