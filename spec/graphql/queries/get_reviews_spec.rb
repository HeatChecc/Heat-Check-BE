# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  describe '.reviews' do
    before :each do
      ethan = User.create!(username: 'ethan', email: 'ethan@ethan.com')
      gauri = User.create!(username: 'gauri', email: 'gauri@gauri.com')

      pad_thai = Dish.create!(name: 'pad thai', cuisine_type: 'thai', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
                              spice_rating: 3)
      hot_wings = Dish.create!(name: 'hot wings', cuisine_type: 'murican', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
                               spice_rating: 2)

      Review.create!(description: 'yummers', overall_rating: 3, user_id: ethan.id, dish_id: pad_thai.id)
      Review.create!(description: 'blammo', overall_rating: 5, user_id: gauri.id, dish_id: pad_thai.id)
      Review.create!(description: 'ouch', overall_rating: 1, user_id: ethan.id, dish_id: hot_wings.id)
    end

    it 'can get reviews' do
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']['reviews']
      expect(data.count).to eq(3)
      data.each do |review|
        expect(review['id']).to be_a(String)
        expect(review['description']).to be_a(String)
        expect(review['overallRating']).to be_a(Integer)
        expect(review['userId']).to be_a(Integer)
        expect(review['dishId']).to be_a(Integer)
      end
    end
  end

  def query
    <<~GQL
            { reviews {
          id
          description
          overallRating
          userId
          dishId
        }
      }
    GQL
  end
end
