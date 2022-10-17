# frozen_string_literal: true

class Dish < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates_presence_of :cuisine_type
  validates_presence_of :yelp_id
  has_many :reviews, dependent: :destroy
  has_many :users, through: :reviews
end
