module Mutations
  module Dishes
    # module Reviews
        class CreateDishReviews < ::Mutations::BaseMutation
            argument :name, String, required: true
            argument :yelp_id, String, required: true
            argument :cuisine_type, String, required: true
            argument :spice_rating, Integer, required: true
            argument :description, String, required: true
            argument :overall_rating, Integer, required: true
            argument :user_id, ID, required: false
            argument :dish_id, ID, required: false
            type Types::DishType
            type Types::ReviewType

            def resolve(attributes)
                binding.pry
                Dish.create(attributes)
            end
        end
    # end
  end
end
