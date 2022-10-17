# frozen_string_literal: true

class AddOverallRatingToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :overall_rating, :integer
  end
end
