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

    expect(@restaurant.dishes).to eq([dish_1, dish_2])
  end
end

# it 'can get a restaurants dishes' do
#   dish_1 = Dish.create(name: 'pad thai', cuisine_type: 'thai', yelp_id: 'eCkWoMKHh5PoNqYvdyviRA', spice_rating: 3)
#   dish_2 = Dish.create!(name: 'ghost pepper', cuisine_type: 'pain', yelp_id: 'eCkWoMKHh5PoNqYvdyviRA',
#                         spice_rating: 5)
#   hot_wings = Dish.create!(name: 'hot wings', cuisine_type: 'murican', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g', spice_rating: 2)
#   burrito = Dish.create!(name: 'santiagos', cuisine_type: 'mexican', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g', spice_rating: 4)
#   gumbo = Dish.create!(name: 'gumbo', cuisine_type: 'mexican', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g', spice_rating: 4)
#   toast_pepper = Dish.create!(name: 'toast pepper', cuisine_type: 'pain', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
#                               spice_rating: 5)
#   green_chile = Dish.create!(name: 'green chile', cuisine_type: 'southwest', yelp_id: 'OT6MJNr8Gzd9nyf25dEl6g',
#                               spice_rating: 3)

#   expect(@restaurant.heat_rating).to eq("?")
# end
