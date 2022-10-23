# frozen_string_literal: true

module Mutations
  module Users
    class CreateUser < ::Mutations::BaseMutation
      argument :email, String, required: true
      argument :username, String, required: true
      type Types::UserType

      def resolve(attributes)
        user = User.new(attributes)
        if user.save
          user
        else
          raise GraphQL::ExecutionError, user.errors.full_messages.join(", ")
        end
      end
    end
  end
end
