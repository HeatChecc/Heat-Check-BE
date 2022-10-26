# frozen_string_literal: true

class Restaurant
  include DishHelper
  attr_reader :name,
              :rating,
              :price,
              :image_url,
              :url,
              :categories,
              :address,
              :phone,
              :lat,
              :lon,
              :city,
              :dishes,
              :heat_rating,
              :alias,
              :id

  def initialize(data = {})
    @name = nil_check(data[:name])
    @rating = nil_check(data[:rating])
    @price = nil_check(data[:price])
    @image_url = nil_check(data[:image_url])
    @url = nil_check(data[:url])
    @categories = data[:categories] ? data[:categories].map { |cat| cat[:title] } * ', ' : 'Not found'
    @address = data[:location] ? data[:location][:display_address] * ', ' : 'Not found'
    @phone = nil_check(data[:display_phone])
    @lat = data[:coordinates] ? data[:coordinates][:latitude] : 'Not found'
    @lon = data[:coordinates] ? data[:coordinates][:longitude] : 'Not found'
    @city = data[:location] ? "#{data[:location][:city]}, #{data[:location][:state]}" : 'Not found'
    @alias = nil_check(data[:alias])
    @id = nil_check(data[:id])
  end

  def nil_check(attribute)
    ['', nil].include?(attribute) ? 'Not found' : attribute
  end

  def dishes
    html_dishes
    Dish.duplicate_dish.destroy_all
    Dish.where(yelp_id: @id)
  end
  
  def heat_rating
    if dishes.present?
      Dish.ratings_by_restaurant(@id).round(2)
    else
      'Not found'
    end
  end
end
