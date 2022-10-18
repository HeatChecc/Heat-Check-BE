# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # field :users, [Types::UserType], null: false

    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    def user(id:)
      User.find(id)
    end

    field :dish, Types::DishType, null: false do
      argument :id, ID, required: true
    end

    def dish(id:)
      Dish.find(id)
    end

    field :review, Types::ReviewType, null: false do
      argument :id, ID, required: true
    end

    def review(id:)
      Review.find(id)
    end

    field :restaurants, [Types::RestaurantType], null: false do
      argument :location, String, required: true
    end

    def restaurants(location:)
      RestaurantsFacade.restaurants_near(location)
    end
  end
end
