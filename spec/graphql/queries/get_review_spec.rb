# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  before do
    @eli = User.create!(username: 'eli', email: 'eli@eli.com')
    @burrito = Dish.create!(name: 'santiagos', cuisine_type: 'mexican', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
                            spice_rating: 4)
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

    it 'can query review sad path' do
      post '/graphql', params: { query: bad_query }
      json = JSON.parse(response.body)

      expect(json).to have_key('errors')
      expect(json['errors'].first['message']).to eq('Review not found')
    end

    it 'can query review sad path 2' do
      post '/graphql', params: { query: nil }
      json = JSON.parse(response.body)
      expect(json['errors'].first['message']).to eq('No query string was present')
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

  def bad_query
    <<~GQL
      { review(id: "9999") {
          description
          overallRating
          userId
          dishId
        }
      }
    GQL
  end
end
