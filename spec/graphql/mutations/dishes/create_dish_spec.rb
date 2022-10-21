# frozen_string_literal: true

require 'rails_helper'

module Mutations
  module Dishes
    RSpec.describe CreateDish, type: :request do
      describe '.resolve' do
        it 'creates a dish' do
          expect(Dish.count).to eq(0)
          post '/graphql', params: { query: query }
          expect(Dish.count).to eq(1)
        end

        it 'returns a dish' do
          post '/graphql', params: { query: query }
          json = JSON.parse(response.body)
          data = json['data']['dish']
          expect(data).to include({ 'name' => 'Pad Thai',
                                    'cuisineType' => 'Thai',
                                    'yelpId' => '123',
                                    'spiceRating' => 2 })
        end
      end

      def query
        <<~GQL
          mutation {
            dish: createDish(
              input: {
                name: "Pad Thai"
                cuisineType: "Thai"
                yelpId: "123"
                spiceRating: 2
              }
            ) {
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
