# frozen_string_literal: true

require 'rails_helper'

module Mutations
  module Reviews
    RSpec.describe CreateReview, type: :request do
      describe '.resolve' do
        before :each do
          @user_1 = User.create!(username: 'philipp', email: 'blahblah.com')
          @dish_1 = Dish.create!(name: 'Pad Thai', cuisine_type: 'Thai', yelp_id: 'abc', spice_rating: 3)
          @query = <<~GQL
            mutation {
              review: createReview(
                          input: {
                            description: "yummers"
                            overallRating: 4
                            userId: "#{@user_1.id}"
                            dishId: "#{@dish_1.id}"
                          }
                  ) {#{' '}
                      description
                      overallRating
                      userId
                      dishId
                      }#{' '}
                    }
          GQL
        end

        it 'creates a review' do
          expect(Review.count).to eq(0)
          post '/graphql', params: { query: @query }
          expect(Review.count).to eq(1)
        end

        it 'returns a review' do
          post '/graphql', params: { query: @query }
          json = JSON.parse(response.body)
          data = json['data']
          expect(data['review']['description']).to eq('yummers')
          expect(data['review']['overallRating']).to eq(4)
        end

        it 'does not create review if invalid params' do
          post '/graphql', params: { query: bad_query }
          json = JSON.parse(response.body)
          result = json['data']['review']
          messages = json['errors'].first['message']

          expect(result).to eq(nil)
          expect(messages).to eq("Description can't be blank")
        end
      end

      def bad_query
        <<~GQL
          mutation{#{' '}
            review: createReview(
              input: {
                description: ""
                overallRating: 4
                userId: "#{@user_1.id}"
                dishId: "#{@dish_1.id}"
              } )#{' '}
                {
                  description
                  overallRating
                  userId
                  dishId
                }
              }
        GQL
      end
    end
  end
end
