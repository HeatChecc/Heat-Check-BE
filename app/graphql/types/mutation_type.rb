module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :users, [Type::UserType], null: false,
      description: "An example field added by the generator"
    
    def users
      User.all
    end
  end
end
