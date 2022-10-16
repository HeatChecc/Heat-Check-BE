require 'rails_helper'

module Mutations
  module Reviews
    RSpec.describe CreateReview, type: :request do
      describe '.resolve' do
        it 'creates a review' do
            @dish_1 = Dish.create(name: "Pad Thai but spicierrrr", cuisine_type: "Thai", yelp_id: "1")
            @user_1 = User.create(username: "philipp", email: "philyphilp@phil.com")
          expect(Review.count).to eq(0)
          post '/graphql', params: {query: query}
          expect(Review.count).to eq(1)
       end

        it 'returns a review' do
          post '/graphql', params: {query: query}
          json = JSON.parse(response.body)
          data = json['data']

          expect(data['review']['description']).to eq('yummers')
          expect(data['review']['overall_rating']).to eq(4)
        end
      end

      def query
        binding.pry
        <<~GQL
        mutation {
          review: createReview(
          input: {
            description: "yummers"
            overall_rating: "4"
            user_id: "#{@user_1.id}"
            dish_id: "#{@dish_1.id}"
          }
        ) { 
          description
          overall_rating
          user_id
          dish_id
          } 
        }
        GQL
      end
    end
  end
end
