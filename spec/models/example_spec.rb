require 'rails_helper'
require 'support/factory_bot' 

RSpec.describe Example, type: :model do
let(:example) { create(:example) }
  describe 'is example valid?' do
    it 'valid?' do
      example.example = nil
      expect(example).to_not be_valid
    end
    it 'valid?' do
      example.phrase_id = nil
      expect(example).to_not be_valid
    end
    it 'valid?' do
      example.user_id = nil
      expect(example).to_not be_valid
    end
  end

end
