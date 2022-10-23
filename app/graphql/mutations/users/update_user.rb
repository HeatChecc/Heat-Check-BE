# frozen_string_literal: true

module Mutations
  module Users
    class UpdateUser < ::Mutations::BaseMutation
      argument :id, ID, required: true
      argument :email, String, required: false
      argument :username, String, required: false
      type Types::UserType

      def resolve(attributes)
        user = User.where(id: attributes[:id]).first
        if user.update(attributes)
          user
        else
          raise GraphQL::ExecutionError, user.errors.full_messages.join(", ")
        end
      end
    end
  end
end
