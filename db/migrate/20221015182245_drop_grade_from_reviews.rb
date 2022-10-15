class DropGradeFromReviews < ActiveRecord::Migration[5.2]
  def change
    remove_column :reviews, :grade
  end
end
