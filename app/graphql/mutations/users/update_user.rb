module Mutations
  module Users
    class UpdateUser < ::Mutations::BaseMutation
      argument :id, ID, required: true
      argument :email, String, required: false
      argument :username, String, required: false
      type Types::UserType

      def resolve(attributes)
        user = User.where(id: attributes[:id]).first
        user.update(attributes)
        user
      end
    end
  end
end