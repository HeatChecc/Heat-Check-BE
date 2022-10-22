# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  before do
    @phil = User.create!(username: 'phil', email: 'phil@phil.com')
    @gauri = User.create!(username: 'gauri', email: 'gauri@gauri.com')
    @pad_thai = Dish.create!(name: 'pad thai', cuisine_type: 'thai', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g', spice_rating: 3)
    @review = Review.create!(description: 'blammo', overall_rating: 5, user_id: @phil.id, dish_id: @pad_thai.id)
    @review_2 = Review.create!(description: 'yummers', overall_rating: 3, user_id: @gauri.id, dish_id: @pad_thai.id)
  end
  describe '.dish(id:)' do
    it 'can query a single dish' do
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']['dish']
      expect(data['name']).to eq('pad thai')
      expect(data['cuisineType']).to eq('thai')
      expect(data['yelpId']).to eq('OT6MJNr8Gzd9nyf25dEl6g')
      expect(data['spiceRating']).to eq(3)
      expect(data['reviews'].size).to eq(2)
    end
    it 'will error out if no dish is passed through' do 
      post '/graphql', params: { query: bad_query }
      json = JSON.parse(response.body)

      expect(json).to include("errors")
      # require 'pry'; binding.pry 
    end
  end

  def query
    <<~GQL
        {
      dish(id: "#{@pad_thai.id}") {
          id
          name
          cuisineType
          yelpId
          spiceRating
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
      dish(" ") {
          id
          name
          cuisineType
          yelpId
          spiceRating
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
