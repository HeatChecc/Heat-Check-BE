# frozen_string_literal: true

module Mutations
  module Reviews
    class UpdateReview < ::Mutations::BaseMutation
      argument :id, ID, required: true
      argument :description, String, required: false
      argument :overall_rating, Integer, required: false
      type Types::ReviewType

      def resolve(attributes)
        review = Review.where(id: attributes[:id]).first
        if review.update(attributes)
          review
        else
          raise GraphQL::ExecutionError, review.errors.full_messages.join(", ")
        end
      end
    end
  end
end
