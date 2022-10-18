require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  before do
    @eli = User.create!(username: 'eli', email: 'eli@eli.com')
    @burrito = Dish.create!(name: 'santiagos', cuisine_type: 'mexican', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g', spice_rating: 4)
    @review = Review.create!(description: 'yummers', overall_rating: 3, user_id: @eli.id, dish_id: @burrito.id)
  end
  describe '.review(id:)' do
    it 'can query a single review' do
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']['review']
      expect(data['description']).to eq('yummers')
      expect(data['overallRating']).to eq(3)
      expect(data['userId']).to eq(@eli.id)
      expect(data['dishId']).to eq(@burrito.id)
    end
  end

  def query
    <<~GQL
      { review(id: "#{@review.id}") {
          description
          overallRating
          userId
          dishId
        }
      }
    GQL
  end
end
