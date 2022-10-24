# frozen_string_literal: true

require 'rails_helper'

module Mutations
  module Dishes
    RSpec.describe Types::QueryType, type: :request do
      describe '.hottest_dishes' do
        before do
          @pad_thai = Dish.create!(name: 'pad thai', cuisine_type: 'thai', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
                                   spice_rating: 3)
          @hot_wings = Dish.create!(name: 'hot wings', cuisine_type: 'murican', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
                                    spice_rating: 2)
          @burrito = Dish.create!(name: 'santiagos', cuisine_type: 'mexican', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
                                  spice_rating: 4)
          @gumbo = Dish.create!(name: 'gumbo', cuisine_type: 'mexican', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
                                spice_rating: 4)
          @ghost_pepper = Dish.create!(name: 'ghost pepper', cuisine_type: 'pain', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
                                       spice_rating: 5)
          @green_chile = Dish.create!(name: 'green chile', cuisine_type: 'southwest', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
                                      spice_rating: 3)
        end

        it 'gets top [i] dishes with highest rating' do
          post '/graphql', params: { query: query }
          json = JSON.parse(response.body)
          data = json['data']['hottestDishes']

          expect(data.count).to eq(3)
          data.each do |dish|
            expect(dish['id']).to be_a(String)
            expect(dish['name']).to be_a(String)
            expect(dish['spiceRating']).to be_a(Integer)
            expect(dish['yelpId']).to eq('OT6MJNr8Gzd9nyf25dEl6g')
          end
        end

        it 'errors out if no amount is passed through' do
          post '/graphql', params: { query: bad_query }
          json = JSON.parse(response.body)
          expect(json).to include('errors')
        end

        def query
          <<~GQL
              { hottestDishes(amt: 3) {
                  id
                  name
                  cuisineType
                  yelpId
                  spiceRating
              }
            }
          GQL
        end

        def bad_query
          <<~GQL
              { hottestDishes(amt: "") {
                  id
                  name
                  cuisineType
                  yelpId
                  spiceRating
              }
            }
          GQL
        end
      end
    end
  end
end
