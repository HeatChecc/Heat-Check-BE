# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Restaurant do
  before :each do
    @data = {
      "id": 'eCkWoMKHh5PoNqYvdyviRA',
      "alias": 'spinellis-market-denver-3',
      "name": "Spinelli's Market",
      "image_url": 'https://s3-media4.fl.yelpcdn.com/bphoto/I41o6sGOiWJwgO5yxxQFwg/o.jpg',
      "is_closed": false,
      "url": 'https://www.yelp.com/biz/spinellis-market-denver-3?adjust_creative=3gRykLgv5-_vxngoRlAFrQ&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=3gRykLgv5-_vxngoRlAFrQ',
      "review_count": 246,
      "categories": [
        {
          "alias": 'delis',
          "title": 'Delis'
        },
        {
          "alias": 'gourmet',
          "title": 'Specialty Food'
        },
        {
          "alias": 'grocery',
          "title": 'Grocery'
        }
      ],
      "rating": 4.5,
      "coordinates": {
        "latitude": 39.751168,
        "longitude": -104.933227
      },
      "transactions": [
        'pickup'
      ],
      "price": '$$',
      "location": {
        "address1": '4621 E 23rd Ave',
        "address2": '',
        "address3": nil,
        "city": 'Denver',
        "zip_code": '80207',
        "country": 'US',
        "state": 'CO',
        "display_address": [
          '4621 E 23rd Ave',
          'Denver, CO 80207'
        ]
      },
      "phone": '+13033298143',
      "display_phone": '(303) 329-8143',
      "distance": 101.23958944836664
    }

    @restaurant = Restaurant.new(@data)
  end

  it 'exists' do
    expect(@restaurant).to be_a(Restaurant)
  end

  it 'has attributes' do
    expect(@restaurant.name).to eq("Spinelli's Market")
    expect(@restaurant.rating).to eq(4.5)
    expect(@restaurant.price).to eq('$$')
    expect(@restaurant.image_url).to eq('https://s3-media4.fl.yelpcdn.com/bphoto/I41o6sGOiWJwgO5yxxQFwg/o.jpg')
    expect(@restaurant.url).to include('https://www.yelp.com/biz/spinellis-market-denver')
    expect(@restaurant.categories).to eq('Delis, Specialty Food, Grocery')
    expect(@restaurant.address).to eq('4621 E 23rd Ave, Denver, CO 80207')
    expect(@restaurant.phone).to eq('(303) 329-8143')
    expect(@restaurant.lat).to eq(39.751168)
    expect(@restaurant.lon).to eq(-104.933227)
    expect(@restaurant.id).to eq('eCkWoMKHh5PoNqYvdyviRA')
    expect(@restaurant.city).to eq('Denver, CO')
  end

  it 'errors gracefully' do
    bad_restaurant = Restaurant.new({})
    expect(bad_restaurant.name).to eq('Not found')
    expect(bad_restaurant.rating).to eq('Not found')
    expect(bad_restaurant.price).to eq('Not found')
    expect(bad_restaurant.image_url).to eq('Not found')
    expect(bad_restaurant.url).to eq('Not found')
    expect(bad_restaurant.categories).to eq('Not found')
    expect(bad_restaurant.address).to eq('Not found')
    expect(bad_restaurant.phone).to eq('Not found')
    expect(bad_restaurant.lat).to eq('Not found')
    expect(bad_restaurant.lon).to eq('Not found')
    expect(bad_restaurant.id).to eq('Not found')
    expect(bad_restaurant.city).to eq('Not found')
  end

  it 'can get a restaurants dishes' do
    dish_1 = Dish.create(name: 'pad thai', cuisine_type: 'thai', yelp_id: 'eCkWoMKHh5PoNqYvdyviRA', spice_rating: 3)
    dish_2 = Dish.create!(name: 'ghost pepper', cuisine_type: 'pain', yelp_id: 'eCkWoMKHh5PoNqYvdyviRA',
                          spice_rating: 5)
    dish_3 = Dish.create!(name: 'hot wings', cuisine_type: 'murican', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g', spice_rating: 2)

    expect(@restaurant.dishes).to eq([dish_1, dish_2])
    expect(@restaurant.dishes).to_not include(dish_3)
  end

  context 'reviews' do
    before do
      @ethan = User.create!(username: 'ethan', email: 'ethan@ethan.com')
      @gauri = User.create!(username: 'gauri', email: 'gauri@gauri.com')
      @eli = User.create!(username: 'eli', email: 'eli@eli.com')
      @phil = User.create!(username: 'phil', email: 'phil@phil.com')
      @dish_1 = Dish.create(name: 'pad thai', cuisine_type: 'thai', yelp_id: 'eCkWoMKHh5PoNqYvdyviRA', spice_rating: 3)
      @dish_2 = Dish.create!(name: 'ghost pepper', cuisine_type: 'pain', yelp_id: 'eCkWoMKHh5PoNqYvdyviRA', spice_rating: 5)
      @dish_3 = Dish.create!(name: 'hot wings', cuisine_type: 'murican', yelp_id: 'eCkWoMKHh5PoNqYvdyviRA', spice_rating: 2)
      @review_1 = Review.create!(description: 'merp', overall_rating: 5, user_id: @gauri.id, dish_id: @dish_1.id)
      @review_2 = Review.create!(description: 'merp', overall_rating: 3, user_id: @gauri.id, dish_id: @dish_2.id)
      @review_3 = Review.create!(description: 'merp', overall_rating: 2, user_id: @gauri.id, dish_id: @dish_3.id)
      @review_4 = Review.create!(description: 'merp', overall_rating: 2, user_id: @ethan.id, dish_id: @dish_1.id)
      @review_5 = Review.create!(description: 'merp', overall_rating: 1, user_id: @ethan.id, dish_id: @dish_2.id)
      @review_6 = Review.create!(description: 'merp', overall_rating: 4, user_id: @ethan.id, dish_id: @dish_3.id)
      @review_7 = Review.create!(description: 'merp', overall_rating: 5, user_id: @eli.id, dish_id: @dish_1.id)
      @review_8 = Review.create!(description: 'merp', overall_rating: 4, user_id: @eli.id, dish_id: @dish_2.id)
      @review_9 = Review.create!(description: 'merp', overall_rating: 5, user_id: @eli.id, dish_id: @dish_3.id)
      @review_10 = Review.create!(description: 'merp', overall_rating: 4, user_id: @phil.id, dish_id: @dish_1.id)
      @review_11 = Review.create!(description: 'merp', overall_rating: 3, user_id: @phil.id, dish_id: @dish_2.id)
      @review_12 = Review.create!(description: 'merp', overall_rating: 3, user_id: @phil.id, dish_id: @dish_3.id)
    end

    it 'can get a restaurants heat rating' do
      expect(@restaurant.heat_rating).to eq(3.42)
    end

    it 'returns not found if restaurant has no dishes', :vcr do
      restaurant_2 = RestaurantsFacade.get_restaurant("OT6MJNr8Gzd9nyf25dEl6g")

      expect(restaurant_2.dishes).to eq([])
      expect(restaurant_2.heat_rating).to eq("Not found")
    end
  end
end
