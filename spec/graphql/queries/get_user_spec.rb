require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  before do
    @user = User.create!(username: "wub", email: "wub@dub.com")
  end
  describe '.user(id:)' do
    it 'can query a single user' do
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']['user']
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
end