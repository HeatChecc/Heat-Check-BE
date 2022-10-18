# frozen_string_literal: true

module Mutations
  module Dishes
    class CreateDish < ::Mutations::BaseMutation
      argument :name, String, required: true
      argument :yelp_id, String, required: true
      argument :cuisine_type, String, required: true
      argument :spice_rating, Integer, required: true
      type Types::DishType

      def resolve(attributes)
        Dish.create(attributes)
      end
    end
  end
end
