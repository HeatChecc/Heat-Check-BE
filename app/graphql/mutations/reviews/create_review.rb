# frozen_string_literal: true

module Mutations
  module Reviews
    class CreateReview < ::Mutations::BaseMutation
      argument :description, String, required: true
      argument :overall_rating, Integer, required: true
      argument :user_id, ID, required: true
      argument :dish_id, ID, required: true
      type Types::ReviewType

      def resolve(attributes)
        review = Review.new(attributes)
        if review.save
          review
        else
          raise GraphQL::ExecutionError, review.errors.full_messages.join(', ')
        end
      end
    end
  end
end
