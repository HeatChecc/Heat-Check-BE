# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RestaurantsService do
  it 'gets a single restaurant by id', :vcr do
    id = "Sk89ZllCbWVqA4M_MoJ7Lg"
    response = RestaurantsService.get_restaurant(id)
    
    expect(response).to be_a(Hash)
    expect(response).to have_key(:name)
    expect(response).to have_key(:rating)
    expect(response).to have_key(:image_url)
    expect(response).to have_key(:url)
    expect(response).to have_key(:categories)
    expect(response).to have_key(:location)
    expect(response).to have_key(:display_phone)
    expect(response).to have_key(:coordinates)
  end
  

  it 'can SAD PATH', :vcr do
    id = ''
    response = RestaurantsService.get_restaurant(id)
    expect(response).to eq({ "error": { "code": 'NOT_FOUND', "description": "Resource could not be found.",
                                        }})                                  
  end
end
