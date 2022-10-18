# frozen_string_literal: true

module Mutations
  module Reviews
    class DeleteReview < ::Mutations::BaseMutation
      argument :id, ID, required: true
      type Types::ReviewType

      def resolve(attributes)
        review = Review.where(id: attributes[:id]).first
        review.delete
      end
    end
  end
end
