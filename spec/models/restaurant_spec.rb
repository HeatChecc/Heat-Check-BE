require 'rails_helper'

RSpec.describe Restaurant do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :image_url }
    it { should validate_presence_of :address }
    it { should validate_presence_of :phone }
    it { should validate_presence_of :rating }
    it { should validate_presence_of :price }
    it { should have_many(:ratings) }
    it { should have_many(:dishes) }
    it { should have_many(:users).through(:ratings) }
  end
end