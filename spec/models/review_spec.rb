# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review do
  describe 'validations' do
    it { should validate_presence_of :description }
    it { should validate_presence_of :overall_rating }
    it { should belong_to(:user) }
    it { should belong_to(:dish) }
  end
end
