# frozen_string_literal: true

class Dish < ApplicationRecord
  validates :name, presence: true
  validates_presence_of :cuisine_type
  validates_presence_of :yelp_id
  has_many :reviews, dependent: :destroy
  has_many :users, through: :reviews

  def self.hottest(amt)
    order(spice_rating: :desc).limit(amt)
  end

  def self.popular_cuisine
    group(:cuisine_type)
      .select(:cuisine_type)
      .order(count: :desc)
      .first.cuisine_type
  end

  def avg_rating
    reviews.average(:overall_rating).to_f
  end

  def self.ratings_by_restaurant(yelpid)
    where('dishes.yelp_id = ?', yelpid.to_s)
      .joins(:reviews)
      .average(:overall_rating).to_f
  end

  def self.duplicate_dish
    unique = self.select('DISTINCT ON(dishes.name, dishes.yelp_id) dishes.id')
     .order(:name, :yelp_id, :id)
    self.where.not(id: unique)
  end
end
