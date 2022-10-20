# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dish do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :cuisine_type }
    it { should validate_presence_of :yelp_id }
    it { should have_many(:reviews) }
    it { should have_many(:users).through(:reviews) }
  end

  describe '.class_methods' do
    context '.hottest' do
      it 'gets the highest spice_rating dishes' do
        pad_thai = Dish.create!(name: 'pad thai', cuisine_type: 'thai', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g', spice_rating: 3)
        hot_wings = Dish.create!(name: 'hot wings', cuisine_type: 'murican', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g', spice_rating: 2)
        burrito = Dish.create!(name: 'santiagos', cuisine_type: 'mexican', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g', spice_rating: 4)
        gumbo = Dish.create!(name: 'gumbo', cuisine_type: 'mexican', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g', spice_rating: 4)
        ghost_pepper = Dish.create!(name: 'ghost pepper', cuisine_type: 'pain', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
                                    spice_rating: 5)
        green_chile = Dish.create!(name: 'green chile', cuisine_type: 'southwest', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
                                   spice_rating: 3)

        spicy_boys = [ghost_pepper, burrito, gumbo]

        expect(Dish.hottest(3)).to eq(spicy_boys) 
      end
    end
  end
end
