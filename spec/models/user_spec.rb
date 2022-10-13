require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :username }
    it { should validate_uniqueness_of :username }
    it { should have_many(:ratings) }
    it { should have_many(:reviews) }
    it { should have_many(:dishes).through(:reviews) }
    it { should have_many(:restaurants).through(:ratings) }
  end
end