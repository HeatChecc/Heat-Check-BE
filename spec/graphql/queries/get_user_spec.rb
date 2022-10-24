# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  before do
    @user = User.create!(username: 'wub', email: 'wub@dub.com')
  end

  describe '.user(id:)' do
    it 'can query a single user' do
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']['user']
      expect(data['username']).to eq('wub')
      expect(data['email']).to eq('wub@dub.com')
    end

    it 'can query single user sad path' do
      post '/graphql', params: { query: bad_query }
      json = JSON.parse(response.body)

      expect(json).to have_key('errors')
      expect(json['errors'].first['message']).to eq('User not found')
    end

    it 'can query single user sad path 2' do
      post '/graphql', params: { query: nil }
      json = JSON.parse(response.body)
      expect(json['errors'].first['message']).to eq('No query string was present')
    end
  end

  def query
    <<~GQL
      { user(id: "#{@user.id}") {
          username
          email
        }
      }
    GQL
  end

  def bad_query
    <<~GQL
      { user(id: "9999") {
          username
          email
        }
      }
    GQL
  end
end
