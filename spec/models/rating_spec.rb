require 'rails_helper'

RSpec.describe Rating do
  describe 'validations' do
    it { should validate_presence_of :grade }
    it { should belong_to(:user) }
    it { should belong_to(:restaurant) }
  end
end