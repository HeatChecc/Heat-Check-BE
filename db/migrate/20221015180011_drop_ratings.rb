# frozen_string_literal: true

class DropRatings < ActiveRecord::Migration[5.2]
  def change
    drop_table :ratings, force: :cascade
  end
end
