# frozen_string_literal: true

require 'rails_helper'

module Mutations
  module Dishes
    RSpec.describe DeleteDish, type: :request do
      describe '.resolve' do
        before do
          @dish_1 = Dish.create(name: 'Pad Thai', cuisine_type: 'Thai', yelp_id: '1', spice_rating: 3)
          @query = <<~GQL
            mutation {
              dish: deleteDish(
                input: {
                  id: "#{@dish_1.id}"
                }
              ) {
                id
              }
            }
          GQL
        end

        it 'deletes dishes and reviews' do 
          eli = User.create!(username: 'eli', email: 'eli@eli.com')
          gauri = User.create!(username: 'gauri', email: 'gauri@gauri.com')
          Review.create!(description: 'yummers', overall_rating: 3, user_id: eli.id, dish_id: @dish_1.id)
          Review.create!(description: 'blammo', overall_rating: 5, user_id: gauri.id, dish_id: @dish_1.id)
          expect(Review.count).to eq(2)
          post '/graphql', params: { query: @query }
          expect(Review.count).to eq(0)
        end

        it 'deletes an existing dish' do
          expect(Dish.count).to eq(1)
          post '/graphql', params: { query: @query }
          json = JSON.parse(response.body)
          data = json['data']
          expect(Dish.count).to eq(0)
        end
      end
    end
  end
end
