require 'rails_helper'

module Mutations
    module Dishes 
        RSpec.describe CreateDishReviews, type: :request do
            describe '.resolve' do           
                it 'can get dishes' do
                post '/graphql', params: { query: query }
                json = JSON.parse(response.body)
                binding.pry
                # data = json['data']['dishes']
                # expect(data.count).to eq(3)
                # data.each do |dish|
                #     expect(dish['id']).to be_a(String)
                #     expect(dish['name']).to be_a(String)
                #     expect(dish['spiceRating']).to be_a(Integer)
                #     expect(dish['yelpId']).to eq('OT6MJNr8Gzd9nyf25dEl6g')
                # end
            end
        end

        def query
            <<~GQL
            mutation 
                    { createDishReviews (
                        input: {
                name: "Pad Thai"
                cuisineType: "Thai"
                yelpId: "123"
                spiceRating: 2
                review: createReview(
                          input: {
                            description: "yummers"
                            overallRating: 4
                            userId: null
                            dishId: null
                          })
              })
            }
            GQL
        end
            

        end
    end
end
