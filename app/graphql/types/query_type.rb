# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :users,
          [Types::UserType], null: false

    def users
      User.all
    end

    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    def user(id:)
      User.find(id)
    end

    field :dishes,
          [Types::DishType], null: false

    def dishes
      Dish.all
    end

    field :hottest_dishes,  [Types::DishType], null: false do
      argument :amt, Integer, required: true
    end

    def hottest_dishes(amt)
      n = amt[:amt]
      Dish.hottest(n)
    end

    field :dish, Types::DishType, null: false do
      argument :id, ID, required: true
    end

    def dish(id:)
      Dish.find(id)
    end

    field :reviews,
          [Types::ReviewType], null: false

    def reviews
      Review.all
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

    field :restaurant, Types::RestaurantType, null: false do
      argument :id, String, required: true
    end

    def restaurant(id:)
      result = RestaurantsFacade.get_restaurant(id)
    end
  end
end
