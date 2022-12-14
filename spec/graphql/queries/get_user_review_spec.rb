# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  before do
    @phil = User.create!(username: 'phil', email: 'phil@phil.com')
    @pad_thai = Dish.create!(name: 'pad thai', cuisine_type: 'thai', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g', spice_rating: 3)
    @gumbo = Dish.create!(name: 'gumbo', cuisine_type: 'mexican', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g', spice_rating: 4)
    @review = Review.create!(description: 'blammo', overall_rating: 5, user_id: @phil.id, dish_id: @pad_thai.id)
    @review_2 = Review.create!(description: 'yummers', overall_rating: 3, user_id: @phil.id, dish_id: @gumbo.id)
  end

  describe '.user(id:)' do
    it 'can query a user reviews' do
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']['user']
      expect(data['username']).to eq('phil')
      expect(data['email']).to eq('phil@phil.com')
      expect(data['reviews'].size).to eq(2)
    end

    it 'can query user reviews sad path' do
      post '/graphql', params: { query: nil }
      json = JSON.parse(response.body)
      expect(json['errors'].first['message']).to eq('No query string was present')
    end

    it 'can query user reviews sad path 2' do
      post '/graphql', params: { query: bad_query }
      json = JSON.parse(response.body)

      expect(json).to have_key('errors')
      expect(json['errors'].first['message']).to eq('User not found')
    end
  end

  def query
    <<~GQL
        {
      user(id: "#{@phil.id}") {
          id
          username
          email
          reviews {
              id
              description
              overallRating
              dishId
              userId
          }
         }
        }

    GQL
  end

  def bad_query
    <<~GQL
        {
      user(id: "9999") {
          id
          username
          email
          reviews {
              id
              description
              overallRating
              dishId
              userId
          }
         }
        }

    GQL
  end
end
