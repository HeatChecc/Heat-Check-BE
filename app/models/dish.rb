class Dish < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates_presence_of :cuisine_type
  belongs_to :restaurant
  has_many :reviews, dependent: :destroy
  has_many :users, through: :reviews
end
