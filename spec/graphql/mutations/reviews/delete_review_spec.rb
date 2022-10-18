# frozen_string_literal: true

module Mutations
  module Reviews
    RSpec.describe DeleteReview, type: :request do
      describe '.resolve' do
        before :each do
          @user_1 = User.create!(username: 'phil', email: 'phil@phil.com')
          @dish_1 = Dish.create!(name: 'Pad Thai', cuisine_type: 'Thai', yelp_id: '1', spice_rating: 3)
          @review_1 = Review.create!(description: 'yummers', overall_rating: 4, user_id: @user_1.id,
                                     dish_id: @dish_1.id)
          @query = <<~GQL
            mutation {
              review: deleteReview(
                          input: {
                            id: "#{@review_1.id}"
                          }
                  ) {#{' '}
                      id
                      }#{' '}
                    }
          GQL
        end

        it 'deletes an existing review' do
          expect(Review.count).to eq(1)
          post '/graphql', params: { query: @query }
          json = JSON.parse(response.body)
          data = json['data']
          expect(Review.count).to eq(0)
        end
      end
    end
  end
end
