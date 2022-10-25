# frozen_string_literal: true

module Mutations
  module Users
    class DeleteUser < ::Mutations::BaseMutation
      argument :id, ID, required: true
      type Types::UserType

      def resolve(attributes)
        user = User.where(id: attributes[:id]).first
        user.reviews.destroy_all 
        user.delete
      end
    end
  end
end
