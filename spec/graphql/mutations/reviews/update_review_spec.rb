require 'rails_helper'

module Mutations
  module Reviews
    RSpec.describe UpdateReview, type: :request do
      describe '.resolve' do
        it 'updates a review' do
          @dish_1 = Dish.create!(name: "Pad Thai", cuisine_type: "Thai", yelp_id: "1", spice_rating: 3)
          @user_1 = User.create!(username: "phil", email: "phil@phil.com")
          @review_1 = Review.create!(description: "yummers", overall_rating: 4, user_id: @user_1.id, dish_id: @dish_1.id)
          

          post '/graphql', params: { query: query }
          
          json = JSON.parse(response.body)
          data = json['data']
          expect(data['review']['description']).to eq('eh, actually its not great')
          expect(data['review']['overallRating']).to eq(2)
        end

        def query
          <<~GQL
          mutation {
            review: updateReview(
              input: {
                id: "#{@review_1.id}"
                description: "eh, actually its not great"
                overallRating: 2
              }
              ) {
                description
                overallRating
              }
            }
          GQL
        end
      end
    end
  end
end
