# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  describe '.dishes' do
    before :each do
      @pad_thai = Dish.create!(name: 'pad thai', cuisine_type: 'thai', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
                               spice_rating: 3)
      @hot_wings = Dish.create!(name: 'hot wings', cuisine_type: 'murican', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
                                spice_rating: 2)
      @burrito = Dish.create!(name: 'santiagos', cuisine_type: 'mexican', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
                              spice_rating: 4)
    end

    it 'can get dishes' do
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']['dishes']
      expect(data.count).to eq(3)
      data.each do |dish|
        expect(dish['id']).to be_a(String)
        expect(dish['name']).to be_a(String)
        expect(dish['spiceRating']).to be_a(Integer)
        expect(dish['yelpId']).to eq('OT6MJNr8Gzd9nyf25dEl6g')
      end
    end

    it 'can query dishes sad path' do
      post '/graphql', params: { query: nil }
      json = JSON.parse(response.body)
      expect(json['errors'].first['message']).to eq('No query string was present')
    end
  end

  def query
    <<~GQL
            { dishes {
          id
          name
          cuisineType
          yelpId
          spiceRating
        }
      }
    GQL
  end
end
