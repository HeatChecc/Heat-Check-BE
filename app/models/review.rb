# frozen_string_literal: true

class Review < ApplicationRecord
  validates_presence_of :description
  validates_presence_of :overall_rating
  belongs_to :user
  belongs_to :dish
end
