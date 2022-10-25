# frozen_string_literal: true

require 'rails_helper'

module Mutations
  module Users
    RSpec.describe DeleteUser, type: :request do
      describe '.resolve' do
        it 'deletes a user' do
          @user_1 = User.create!(username: 'eli', email: 'eli@eli.com')
          @user_2 = User.create!(username: 'phil', email: 'phil@phil.com')
          expect(User.count).to eq(2)
          post '/graphql', params: { query: query }

          json = JSON.parse(response.body)
          data = json['data']
          expect(User.count).to eq(1)
        end

        it 'deletes a user and its reviews' do 
          @burrito = Dish.create!(name: 'santiagos', cuisine_type: 'mexican', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g', spice_rating: 4)
          @user_1 = User.create!(username: 'eli', email: 'eli@eli.com')
          @review_1 = Review.create!(description: 'yummers', overall_rating: 3, user_id: @user_1.id, dish_id: @burrito.id)
          expect(Review.count).to eq(1)
          post '/graphql', params: { query: query }
          expect(Review.count).to eq(0)
        end

        def query
          <<~GQL
            mutation {
              user: deleteUser(
                input: {
                  id: "#{@user_1.id}"
                }
                ) {
                  id
                }
              }
          GQL
        end
      end
    end
  end
end
