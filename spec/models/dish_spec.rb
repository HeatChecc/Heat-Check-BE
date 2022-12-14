# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dish do
  describe 'part one' do
    describe 'validations' do
      it { should validate_presence_of :name }
      it { should validate_presence_of :cuisine_type }
      it { should validate_presence_of :yelp_id }
    end

    describe 'relationships' do
      it { should have_many(:reviews) }
      it { should have_many(:users).through(:reviews) }
    end

    before :each do
      @eli = User.create!(username: 'eli', email: 'eli@eli.com')
      @phil = User.create!(username: 'phil', email: 'phil@phil.com')
      @ethan = User.create!(username: 'ethan', email: 'ethan@ethan.com')
      @gauri = User.create!(username: 'gauri', email: 'gauri@gauri.com')

      @pad_thai = Dish.create!(name: 'pad thai', cuisine_type: 'thai', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
                               spice_rating: 3)
      @hot_wings = Dish.create!(name: 'hot wings', cuisine_type: 'murican', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
                                spice_rating: 2)
      @burrito = Dish.create!(name: 'santiagos', cuisine_type: 'mexican', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
                              spice_rating: 4)
      @gumbo = Dish.create!(name: 'gumbo', cuisine_type: 'mexican', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g', spice_rating: 4)
      @ghost_pepper = Dish.create!(name: 'ghost pepper', cuisine_type: 'pain', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
                                   spice_rating: 5)
      @green_chile = Dish.create!(name: 'green chile', cuisine_type: 'southwest', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
                                  spice_rating: 3)

      @review_1 = Review.create!(description: 'yummers', overall_rating: 4, user_id: @eli.id, dish_id: @burrito.id)
      @review_2 = Review.create!(description: 'blammo', overall_rating: 5, user_id: @phil.id, dish_id: @burrito.id)
      @review_3 = Review.create!(description: 'ouch', overall_rating: 4, user_id: @ethan.id, dish_id: @burrito.id)
      @review_4 = Review.create!(description: 'merp', overall_rating: 5, user_id: @gauri.id, dish_id: @burrito.id)
      @review_5 = Review.create!(description: 'burp', overall_rating: 2, user_id: @eli.id, dish_id: @pad_thai.id)
      @review_6 = Review.create!(description: 'wammy', overall_rating: 3, user_id: @phil.id, dish_id: @pad_thai.id)
      @review_7 = Review.create!(description: 'wammy', overall_rating: 2, user_id: @ethan.id, dish_id: @pad_thai.id)
      @review_8 = Review.create!(description: 'wammy', overall_rating: 4, user_id: @gauri.id, dish_id: @pad_thai.id)
      @review_9 = Review.create!(description: 'wammy', overall_rating: 1, user_id: @eli.id, dish_id: @green_chile.id)
      @review_10 = Review.create!(description: 'wammy', overall_rating: 2, user_id: @phil.id, dish_id: @green_chile.id)
      @review_11 = Review.create!(description: 'wammy', overall_rating: 3, user_id: @ethan.id, dish_id: @green_chile.id)
      @review_12 = Review.create!(description: 'wammy', overall_rating: 1, user_id: @gauri.id, dish_id: @green_chile.id)
    end

    describe '.class_methods' do
      context '.hottest' do
        it 'gets the highest spice_rating dishes' do
          spicy_boys = [@ghost_pepper, @burrito, @gumbo]
          expect(Dish.hottest(3)).to eq(spicy_boys)
        end
      end

      context '.popular_cuisine' do
        it 'gets the most popular cuisine based on cuisine type count' do
          expect(Dish.popular_cuisine).to eq('mexican')
        end
      end
    end

    describe 'instance methods' do
      context '.avg_rating' do
        it 'returns average rating for dish' do
          expect(@burrito.avg_rating).to eq(4.5)
          expect(@pad_thai.avg_rating).to eq(2.75)
          expect(@green_chile.avg_rating).to eq(1.75)
        end
      end
    end
  end

  describe 'api methods', :vcr do
    context '.ratings_by_restaurant' do
      it 'gets average rating for restaurants by its total dish review' do
        restaurant_1 = RestaurantsFacade.get_restaurant('Sk89ZllCbWVqA4M_MoJ7Lg')
        restaurant_2 = RestaurantsFacade.get_restaurant('OT6MJNr8Gzd9nyf25dEl6g')
        eli = User.create!(username: 'eli', email: 'eli@eli.com')
        phil = User.create!(username: 'phil', email: 'phil@phil.com')

        hot_wings = Dish.create!(name: 'hot wings', cuisine_type: 'murican', yelp_id: 'Sk89ZllCbWVqA4M_MoJ7Lg',
                                 spice_rating: 2)
        gumbo = Dish.create!(name: 'gumbo', cuisine_type: 'mexican', yelp_id: 'Sk89ZllCbWVqA4M_MoJ7Lg', spice_rating: 4)
        pad_thai = Dish.create!(name: 'pad thai', cuisine_type: 'thai', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
                                spice_rating: 3)
        ghost_pepper = Dish.create!(name: 'ghost pepper', cuisine_type: 'pain', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
                                    spice_rating: 5)

        review_1 = Review.create!(description: 'yummers', overall_rating: 4, user_id: phil.id, dish_id: hot_wings.id)
        review_2 = Review.create!(description: 'blammo', overall_rating: 2, user_id: eli.id, dish_id: hot_wings.id)
        review_3 = Review.create!(description: 'blammo', overall_rating: 3, user_id: phil.id, dish_id: gumbo.id)
        review_4 = Review.create!(description: 'blammo', overall_rating: 1, user_id: eli.id, dish_id: gumbo.id)
        review_5 = Review.create!(description: 'blammo', overall_rating: 2, user_id: phil.id, dish_id: pad_thai.id)
        review_6 = Review.create!(description: 'blammo', overall_rating: 5, user_id: eli.id, dish_id: pad_thai.id)
        review_7 = Review.create!(description: 'blammo', overall_rating: 3, user_id: phil.id, dish_id: ghost_pepper.id)
        review_8 = Review.create!(description: 'blammo', overall_rating: 1, user_id: eli.id, dish_id: ghost_pepper.id)

        expect(Dish.ratings_by_restaurant(restaurant_1.id.to_s)).to eq(2.5)
        expect(Dish.ratings_by_restaurant(restaurant_2.id.to_s)).to eq(2.75)
      end
    end
  end
end
