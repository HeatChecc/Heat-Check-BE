# frozen_string_literal: true

class RestaurantsService
  def self.get_restaurant(id)
    response = conn.get("#{id}")
    parse_json(response)
  end

  def self.restaurants_near(location)
    response = conn.get('search') do |route|
      route.params['limit'] = '20'
      route.params['location'] = location
      route.params['sort_by'] = 'rating'
      route.params['term'] = 'spicy food'
    end
    parse_json(response)
  end

  def self.conn
    Faraday.new(url: 'https://api.yelp.com/v3/businesses') do |faraday|
      faraday.headers['authorization'] = "Bearer #{ENV['yelp_token']}"
    end
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
