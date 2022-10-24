# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  describe '.restaurants(location:)' do
    it 'can get restaurants', vcr: 'denver_restaurants' do
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']['restaurants']
      data.each do |restaurant|
        expect(restaurant['id']).to be_a(String)
        expect(restaurant['city']).to include('CO')
      end
    end

    it 'will not get restaurants with bad location', :vcr do
      post '/graphql', params: { query: bad_query }
      json = JSON.parse(response.body)
      result = json['data']['restaurants']
      expect(result).to eq([])
    end

    it 'can query restaurants sad path' do
      post '/graphql', params: { query: nil }
      json = JSON.parse(response.body)
      expect(json['errors'].first['message']).to eq('No query string was present')
    end
  end

  def query
    <<~GQL
            {#{' '}
        restaurants(location: "Denver") {
          id
          name
          rating
          address
          lat
          lon
          city
        }
      }
    GQL
  end

  def bad_query
    <<~GQL
            {#{' '}
        restaurants(location: "?") {
          id
          name
          rating
          address
          lat
          lon
          city
        }
      }
    GQL
  end
end
