# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :create_user, mutation: Mutations::Users::CreateUser
    field :update_user, mutation: Mutations::Users::UpdateUser
    field :delete_user, mutation: Mutations::Users::DeleteUser
    field :create_dish, mutation: Mutations::Dishes::CreateDish
    field :delete_dish, mutation: Mutations::Dishes::DeleteDish
    field :update_dish, mutation: Mutations::Dishes::UpdateDish
    field :create_review, mutation: Mutations::Reviews::CreateReview
    field :update_review, mutation: Mutations::Reviews::UpdateReview
    field :delete_review, mutation: Mutations::Reviews::DeleteReview
  end
end
