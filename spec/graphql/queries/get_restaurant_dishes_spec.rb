# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  describe '.restaurant(id: )', :vcr do
    before do
      @id = 'Sk89ZllCbWVqA4M_MoJ7Lg'
      @restaurant = RestaurantsFacade.get_restaurant(@id)
      @hot_wings = Dish.create!(name: 'hot wings', cuisine_type: 'murican', yelp_id: @restaurant.id.to_s,
                                spice_rating: 2)
      @burrito = Dish.create!(name: 'santiagos', cuisine_type: 'mexican', yelp_id: @restaurant.id.to_s, spice_rating: 4)
      @gumbo = Dish.create!(name: 'gumbo', cuisine_type: 'mexican', yelp_id: @restaurant.id.to_s, spice_rating: 4)
    end

    it 'returns a restaurant & its dishes' do
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']['restaurant']

      expect(data).to include(
        { 'id' => 'Sk89ZllCbWVqA4M_MoJ7Lg',
          'name' => 'Noodles Express',
          'rating' => '4.5',
          'address' => '703 S Colorado Blvd, Denver, CO 80246',
          'lat' => '39.70269',
          'lon' => '-104.94143',
          'city' => 'Denver, CO',
          'dishes' => [
            { 'name' => 'hot wings', 'spiceRating' => 2 },
            { 'name' => 'santiagos', 'spiceRating' => 4 },
            { 'name' => 'gumbo', 'spiceRating' => 4 }
          ] }
      )
    end
  end

  def query
    <<~GQL
      { restaurant(id: "#{@restaurant.id}") {
        id
        name
        rating
        address
        lat
        lon
        city
        dishes {
          name
          spiceRating
        }
        }
      }
    GQL
  end
end
