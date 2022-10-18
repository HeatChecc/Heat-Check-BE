# frozen_string_literal: true

class RestaurantsFacade
  def self.restaurants_near(location)
    restaurants = RestaurantsService.restaurants_near(location)
    if restaurants[:businesses]
      restaurants[:businesses][0..4].map do |restaurant_data|
        Restaurant.new(restaurant_data)
      end
    else
      []
    end
  end
end
