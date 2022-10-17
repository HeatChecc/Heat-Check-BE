# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :create_user, mutation: Mutations::Users::CreateUser
    field :update_user, mutation: Mutations::Users::UpdateUser
    field :create_review, mutation: Mutations::Reviews::CreateReview
    field :update_review, mutation: Mutations::Reviews::UpdateReview
    field :delete_review, mutation: Mutations::Reviews::DeleteReview
  end
end
