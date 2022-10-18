# frozen_string_literal: true

class Restaurant
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
    @id = data[:id]
  end

  def nil_check(attribute)
    ['', nil].include?(attribute) ? 'Not found' : attribute
  end
end
