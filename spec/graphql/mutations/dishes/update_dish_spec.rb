# frozen_string_literal: true

require 'rails_helper'

module Mutations
  module Dishes
    RSpec.describe UpdateDish, type: :request do
      before do
        @dish_1 = Dish.create(name: 'Pad Thai Hot', cuisine_type: 'Thai', yelp_id: '1', spice_rating: 3)
      end

      describe '.resolve' do
        it 'updates an existing dish' do
          post '/graphql', params: { query: query }
          json = JSON.parse(response.body)
          data = json['data']['dish']
          expect(data).to include(
            'name' => 'Super Spicy Pad Thai',
            'cuisineType' => 'Thai',
            'yelpId' => '1',
            'spiceRating' => 9
          )
        end

        it 'does not update if invalid params' do
          post '/graphql', params: { query: bad_query }
          json = JSON.parse(response.body)
          data = json['data']['dish']
          messages = json['errors'].first['message']

          expect(data).to eq(nil)
          expect(messages).to eq("Name can't be blank, Cuisine type can't be blank, Yelp can't be blank")
        end

        def query
          <<~GQL
            mutation {
              dish: updateDish(
                input: {
                  id: "#{@dish_1.id}"
                  name: "Super Spicy Pad Thai"
                  cuisineType: "Thai"
                  yelpId: "1"
                  spiceRating: 9
                }
              ) {
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
            mutation {
              dish: updateDish(
                input: {
                  id: "#{@dish_1.id}"
                  name: ""
                  cuisineType: ""
                  yelpId: ""
                  spiceRating: 9
                }
              ) {
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
