module Mutations
  module Dishes
    class DeleteDish < ::Mutations::BaseMutation
      argument :id, ID, required: true
      type Types::DishType

      def resolve(attributes)
        dish = Dish.where(id: attributes[:id]).first
        dish.delete
      end
    end
  end
end