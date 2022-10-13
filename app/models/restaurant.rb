class Restaurant < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :image_url
  validates_presence_of :address
  validates_presence_of :phone
  validates_presence_of :rating
  validates_presence_of :price
  has_many :ratings, dependent: :destroy
  has_many :dishes, dependent: :destroy
  has_many :users, through: :ratings
end
