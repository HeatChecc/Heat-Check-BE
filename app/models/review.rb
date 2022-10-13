class Review < ApplicationRecord
  validates_presence_of :description
  validates_presence_of :grade
  belongs_to :user
  belongs_to :dish
end
