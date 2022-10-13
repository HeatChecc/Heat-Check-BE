class Rating < ApplicationRecord
  validates_presence_of :grade
  belongs_to :user
  belongs_to :restaurant
end
