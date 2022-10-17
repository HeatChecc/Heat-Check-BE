require 'rails_helper'

module Mutations
  module Reviews
    RSpec.describe CreateReview, type: :request do
      describe '.resolve' do
        before :each do 
          @user_1 = User.create!(username: "philipp", email: "blahblah.com")
          @dish_1 = Dish.create!(name: "Pad Thai", cuisine_type: "Thai", yelp_id: "abc", spice_rating: 3)
          @query = <<~GQL
                  mutation {
                    review: createReview(
                                input: {
                                  description: "yummers"
                                  overallRating: 4
                                  userId: "#{@user_1.id}"
                                  dishId: "#{@dish_1.id}"
                                }
                        ) { 
                            description
                            overallRating
                            userId
                            dishId
                            } 
                          }
                GQL
        end

        it 'creates a review' do
            # @dish_1 = Dish.create(name: "Pad Thai but spicierrrr", cuisine_type: "Thai", yelp_id: "1")
            # @user_1 = User.create(username: "philipp", email: "philyphilp@phil.com")
          expect(Review.count).to eq(0)
          post '/graphql', params: {query: @query}
          expect(Review.count).to eq(1)
          # require 'pry'; binding.pry 
       end

        it 'returns a review' do
          post '/graphql', params: {query: @query}
          json = JSON.parse(response.body)
          # require 'pry'; binding.pry 
          data = json['data']
          expect(data['review']['description']).to eq('yummers')
          expect(data['review']['overallRating']).to eq(4)
        end
      end

      # def query
      #   <<~GQL
      #   mutation {
      #     review: createReview(
      #     input: {
      #       description: "yummers"
      #       overall_rating: "4"
      #       user_id: "#{@user_1.id}"
      #       dish_id: "#{@dish_1.id}"
      #     }
      #   ) { 
      #     description
      #     overall_rating
      #     user_id
      #     dish_id
      #     } 
      #   }
      #   GQL
      # end
    end
  end
end
