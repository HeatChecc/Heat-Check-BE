require 'rails_helper'

RSpec.describe Dish do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :cuisine_type }
    it { should belong_to(:restaurant) }
    it { should have_many(:reviews) }
    it { should have_many(:users).through(:reviews) }
  end
end