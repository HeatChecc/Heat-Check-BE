# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RestaurantsFacade' do
  it 'returns instances of restaurants', vcr: 'denver_restaurants' do
    restaurants = RestaurantsFacade.restaurants_near('Denver')
    expect(restaurants).to be_a(Array)
    expect(restaurants).to be_all(Restaurant)
    expect(restaurants.length).to eq(20)
  end

  it 'returns single instance of restaurant', :vcr do
    restaurant = RestaurantsFacade.get_restaurant('Sk89ZllCbWVqA4M_MoJ7Lg')
    expect(restaurant).to be_a(Restaurant)
    expect(restaurant).to_not be_a(Array)
  end

  it 'errors gracefully', vcr: 'bad_restaurants' do
    restaurants = RestaurantsFacade.restaurants_near('')
    expect(restaurants).to eq([])
  end

  it 'errors gracefully if no id is given', :vcr do
    restaurant = RestaurantsFacade.get_restaurant('')
    expect(restaurant.name).to eq('Not found')
  end
end
