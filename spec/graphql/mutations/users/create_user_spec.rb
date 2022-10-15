require 'rails_helper'

module Mutations
  module Users
    RSpec.describe CreateUser, type: :request do
      describe '.resolve' do
        it 'creates a user' do
          expect(User.count).to eq(0)
          post '/graphql', params: {query: query}
          expect(User.count).to eq(1)
        end

        it 'returns a user' do
          post '/graphql', params: {query: query}
          json = JSON.parse(response.body)
          data = json['data']

          expect(data['user']['email']).to eq('hello@wassup.com')
          expect(data['user']['username']).to eq('hello')
        end
      end

      def query
        <<~GQL
        mutation {
          user: createUser(
          input: {
            email: "hello@wassup.com"
            username: "hello"
          }
        ) { 
          email
          username
          } 
        }
        GQL
      end
    end
  end
end