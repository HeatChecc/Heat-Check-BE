module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :create_user, mutation: Mutations::Users::CreateUser
    field :update_user, mutation: Mutations::Users::UpdateUser
  end
end
