# frozen_string_literal: true

require 'rails_helper'

module Mutations
  module Users
    RSpec.describe CreateUser, type: :request do
      describe '.resolve' do
        it 'creates a user' do
          expect(User.count).to eq(0)
          post '/graphql', params: { query: query }
          expect(User.count).to eq(1)
        end

        it 'returns a user' do
          post '/graphql', params: { query: query }
          json = JSON.parse(response.body)
          data = json['data']

          expect(data['user']['email']).to eq('hello@wassup.com')
          expect(data['user']['username']).to eq('hello')
        end

        it 'returns errors if invalid user params' do
          post '/graphql', params: { query: bad_query }
          json = JSON.parse(response.body) 
          result = json["data"]["user"]
          messages = json["errors"].first["message"]

          expect(result).to eq(nil)
          expect(messages).to eq("Username can't be blank, Email can't be blank")
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

      def bad_query
        <<~GQL
        mutation {
          user: createUser(
          input: {
            email: ""
            username: ""
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
