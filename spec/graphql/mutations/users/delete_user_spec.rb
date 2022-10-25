# frozen_string_literal: true

require 'rails_helper'

module Mutations
  module Users
    RSpec.describe DeleteUser, type: :request do
      describe '.resolve' do
        before :each do 
          @user_1 = User.create!(username: 'eli', email: 'eli@eli.com')
          @user_2 = User.create!(username: 'phil', email: 'phil@phil.com')
          @burrito = Dish.create!(name: 'santiagos', cuisine_type: 'mexican', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g', spice_rating: 4)
          @review_1 = Review.create!(description: 'yummers', overall_rating: 3, user_id: @user_1.id, dish_id: @burrito.id)
          @review_2 = Review.create!(description: 'so so', overall_rating: 2, user_id: @user_2.id, dish_id: @burrito.id)
        end

        it 'deletes a user' do
          expect(User.count).to eq(2)
          post '/graphql', params: { query: query }
          json = JSON.parse(response.body)
          data = json['data']
          expect(User.count).to eq(1)
        end

        it 'deletes a user and only reviews associated with that user' do 
          expect(Review.count).to eq(2)
          expect(User.count).to eq(2)

          post '/graphql', params: { query: query }
          
          expect(Review.count).to eq(1)
          expect(User.count).to eq(1)
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
