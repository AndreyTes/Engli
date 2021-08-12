require 'rails_helper'
require 'support/factory_bot' 

RSpec.describe Phrase, type: :model do
let(:phrase) { create(:phrase) }
  describe 'is phrase valid?' do
    it 'valid?' do
      phrase.phrase = nil
      expect(phrase).to_not be_valid
    end
    it 'valid?' do
      phrase.translation = nil
      expect(phrase).to_not be_valid
    end
    it 'valid?' do
      phrase.user_id = nil
      expect(phrase).to_not be_valid
    end
  end

end
