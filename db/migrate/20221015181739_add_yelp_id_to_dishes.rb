class AddYelpIdToDishes < ActiveRecord::Migration[5.2]
  def change
    add_column :dishes, :yelp_id, :string
  end
end
