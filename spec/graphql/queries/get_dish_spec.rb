# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  before do
    @dish = Dish.create!(name: 'pad thai', cuisine_type: 'thai', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g', spice_rating: 3)
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
    end
  end

  def query
    <<~GQL
      { dish(id: "#{@dish.id}") {
          name
          cuisineType
          yelpId
          spiceRating
        }
      }
    GQL
  end
end
