require 'rails_helper'

module Mutations
  module Users
    RSpec.describe UpdateUser, type: :request do
      describe '.resolve' do
        it 'updates a user' do
          @user_1 = User.create!(username: "eli", email: "eli@eli.com")
          @user_2 = User.create!(username: "phil", email: "phil@phil.com")

          post '/graphql', params: { query: query }
          
          json = JSON.parse(response.body)
          data = json['data']
          
          expect(data['user']['username']).to eq('superphil')
          expect(data['user']['email']).to eq('phil@phil.com')
          expect(User.find_by(email: 'phil@phil.com').username).to eq('superphil')
        end

        it 'returns updated skills for a user' do
          @cheryl = create(:user, name: "Lana", email: "tunt@gmail.com", mod: "4", program: "BE", pronouns: "she/her", slack:"@cheryl_tunt")
          @pam = create(:user)
          skill_1 = @cheryl.skills.create(name: "sql")
          skill_2 = @cheryl.skills.create(name: "javascript")
          skill_3 = @cheryl.skills.create(name: "graphql")

          expect(@cheryl.skills).to eq([skill_1, skill_2, skill_3])

          post '/graphql', params: { query: query }

          result = JSON.parse(response.body)
          skills = result["data"]["user"]["skills"]

          expect(skills[0]).to eq('ruby')
          expect(skills[1]).to eq('react')
          expect(skills[2]).to eq('css')
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
      end
    end
  end
end