# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  describe '.users' do
    before :each do
      eli = User.create!(username: 'eli', email: 'eli@eli.com')
      phil = User.create!(username: 'phil', email: 'phil@phil.com')
      ethan = User.create!(username: 'ethan', email: 'ethan@ethan.com')
      gauri = User.create!(username: 'gauri', email: 'gauri@gauri.com')
    end

    it 'can get users' do
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']['users']
      expect(data.count).to eq(4)
      data.each do |user|
        expect(user['id']).to be_a(String)
        expect(user['username']).to be_a(String)
        expect(user['email']).to be_a(String)
      end
    end

    it 'can query users sad path' do
      post '/graphql', params: { query: nil }
      json = JSON.parse(response.body)
      expect(json['errors'].first['message']).to eq('No query string was present')
    end
  end

  def query
    <<~GQL
            { users {
          id
          username
          email
        }
      }
    GQL
  end
end
