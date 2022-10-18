# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  describe '.restaurants(location:)', vcr: 'denver_restaurants' do
    it 'can get restaurants' do
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']['restaurants']
      data.each do |restaurant|
        expect(restaurant['id']).to be_a(String)
        expect(restaurant['city']).to eq('Denver, CO')
      end
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
end
