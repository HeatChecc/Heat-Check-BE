# frozen_string_literal: true

module Mutations
  module Dishes
    class UpdateDish < ::Mutations::BaseMutation
      argument :id, ID, required: true
      argument :name, String, required: true
      argument :yelp_id, String, required: true
      argument :cuisine_type, String, required: true
      argument :spice_rating, Integer, required: true
      type Types::DishType

      def resolve(attributes)
        dish = Dish.where(id: attributes[:id]).first
        if dish.update(attributes)
          dish
        else
          raise GraphQL::ExecutionError, dish.errors.full_messages.join(', ')
        end
      end
    end
  end
end
