# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review do
  describe 'validations' do
    it { should validate_presence_of :description }
    it { should validate_presence_of :overall_rating }
  end

  describe 'relationships' do 
    it { should belong_to(:user) }
    it { should belong_to(:dish) }
  end

  describe '.class methods' do
    context '.highest_rating' do
      it 'gets the highest overall rating and ranks them in descending order' do
        eli = User.create!(username: 'eli', email: 'eli@eli.com')
        phil = User.create!(username: 'phil', email: 'phil@phil.com')
        ethan = User.create!(username: 'ethan', email: 'ethan@ethan.com')
        gauri = User.create!(username: 'gauri', email: 'gauri@gauri.com')

        pad_thai = Dish.create!(name: 'pad thai', cuisine_type: 'thai', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
                                spice_rating: 3)
        hot_wings = Dish.create!(name: 'hot wings', cuisine_type: 'murican', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
                                spice_rating: 2)
        burrito = Dish.create!(name: 'santiagos', cuisine_type: 'mexican', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
                              spice_rating: 4)
        gumbo = Dish.create!(name: 'gumbo', cuisine_type: 'mexican', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g', spice_rating: 4)
        ghost_pepper = Dish.create!(name: 'ghost pepper', cuisine_type: 'pain', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
                                    spice_rating: 5)
        green_chile = Dish.create!(name: 'green chile', cuisine_type: 'southwest', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
                                  spice_rating: 3)
        review1 = Review.create!(description: 'yummers', overall_rating: 3, user_id: eli.id, dish_id: burrito.id)
        review2 = Review.create!(description: 'blammo', overall_rating: 5, user_id: phil.id, dish_id: green_chile.id)
        review3 = Review.create!(description: 'ouch', overall_rating: 1, user_id: ethan.id, dish_id: ghost_pepper.id)
        review4 = Review.create!(description: 'merp', overall_rating: 4, user_id: gauri.id, dish_id: pad_thai.id)

        expect(Review.highest_rating).to eq([review2, review4, review1, review3])
      end
    end
  end
end
