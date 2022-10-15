module Mutations
  module Users
    class UpdateUser < ::Mutations::BaseMutation
      argument :email, String, required: false
      argument :username, String, required: false
      type Types::UserType

      def resolve(attributes)
      end
    end
  end
end