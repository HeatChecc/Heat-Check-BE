# frozen_string_literal: true

require 'rails_helper'

module Mutations
  module Users
    RSpec.describe DeleteUser, type: :request do
      describe '.resolve' do
        it 'deletes a user' do
          @user_1 = User.create!(username: 'eli', email: 'eli@eli.com')
          @user_2 = User.create!(username: 'phil', email: 'phil@phil.com')
          expect(User.count).to eq(2)
          post '/graphql', params: { query: query }

          json = JSON.parse(response.body)
          data = json['data']
          expect(User.count).to eq(1)
        end

        def query
          <<~GQL
            mutation {
              user: deleteUser(
                input: {
                  id: "#{@user_2.id}"
                }
                ) {
                  id
                }
              }
          GQL
        end
      end
    end
  end
end
