# frozen_string_literal: true

require 'rails_helper'

module Mutations
  module Users
    RSpec.describe UpdateUser, type: :request do
      describe '.resolve' do
        it 'updates a user' do
          @user_1 = User.create!(username: 'eli', email: 'eli@eli.com')
          @user_2 = User.create!(username: 'phil', email: 'phil@phil.com')

          post '/graphql', params: { query: query }

          json = JSON.parse(response.body)
          data = json['data']

          expect(data['user']['username']).to eq('superphil')
          expect(data['user']['email']).to eq('phil@phil.com')
          expect(User.find_by(email: 'phil@phil.com').username).to eq('superphil')
        end

        it 'does not update if invalid params' do
          @user_3 = User.create(username: 'bob', email: 'bob@bob.com')
          post '/graphql', params: { query: bad_query }

          json = JSON.parse(response.body)
          result = json['data']['user']
          messages = json['errors'].first['message']
          expect(result).to eq(nil)
          expect(messages).to eq("Username can't be blank, Email can't be blank")
        end

        def query
          <<~GQL
            mutation {
              user: updateUser(
                input: {
                  id: "#{@user_2.id}"
                  username: "superphil"
                  email: "phil@phil.com"
                }
                ) {
                  username
                  email
                }
              }
          GQL
        end

        def bad_query
          <<~GQL
            mutation {
              user: updateUser(
                input: {
                  id: "#{@user_3.id}"
                  username: ""
                  email: ""
                }
                ) {
                  username
                  email
                }
              }
          GQL
        end
      end
    end
  end
end
