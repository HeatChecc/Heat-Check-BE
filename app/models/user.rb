class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  has_many :ratings
  has_many :reviews
  has_many :dishes, through: :reviews
  has_many :restaurants, through: :ratings
end
