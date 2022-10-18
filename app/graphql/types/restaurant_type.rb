module Types
  class RestaurantType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :rating, String
    field :price, String
    field :image_url, String
    field :url, String
    field :categories, String
    field :address, String
    field :phone, String
    field :lat, String
    field :lon, String
    field :city, String
    field :dishes, [Types::DishType], null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end