# frozen_string_literal: true

module Types
  class DishType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :cuisine_type, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :yelp_id, String
    field :spice_rating, Integer
  end
end
