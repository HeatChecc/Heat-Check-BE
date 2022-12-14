# frozen_string_literal: true

require 'rails_helper'

module Mutations
  module Reviews
    RSpec.describe UpdateReview, type: :request do
      describe '.resolve' do
        before :each do
          @user_1 = User.create!(username: 'phil', email: 'phil@phil.com')
          @dish_1 = Dish.create!(name: 'Pad Thai', cuisine_type: 'Thai', yelp_id: '1', spice_rating: 3)
          @review_1 = Review.create!(description: 'yummers', overall_rating: 4, user_id: @user_1.id,
                                     dish_id: @dish_1.id)
          @query = <<~GQL
            mutation {
              review: updateReview(
                          input: {
                            description: "eh, actually its not great"
                            overallRating: 2
                            id: "#{@review_1.id}"
                          }
                  ) {#{' '}
                      description
                      overallRating
                      id
                      }#{' '}
                    }
          GQL
        end

        it 'updates an existing review' do
          post '/graphql', params: { query: @query }
          json = JSON.parse(response.body)
          data = json['data']
          expect(data['review']['description']).to eq('eh, actually its not great')
          expect(data['review']['overallRating']).to eq(2)
          expect(data['review']['id']).to eq(@review_1.id.to_s)
        end

        it 'does not update if invalid params' do
          post '/graphql', params: { query: bad_query }
          json = JSON.parse(response.body)
          data = json['data']['review']
          messages = json['errors'].first['message']

          expect(data).to eq(nil)
          expect(messages).to eq("Description can't be blank")
        end

        def bad_query
          <<~GQL
            mutation {
              review: updateReview(
                          input: {
                            description: ""
                            overallRating: 2
                            id: "#{@review_1.id}"
                          }
                  ) {
                      description
                      overallRating
                      id
                    }
                }
          GQL
        end
      end
    end
  end
end
