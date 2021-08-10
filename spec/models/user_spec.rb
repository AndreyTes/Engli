require 'rails_helper'
require 'support/factory_bot' 

RSpec.describe User, type: :model do
let(:user) { create(:user) }

  describe 'is username valid?' do
    it 'valid?' do
      user.username = nil
      expect(user).to_not be_valid
    end
    it 'valid?' do
      user.email = nil
      expect(user).to_not be_valid
    end
  end
  describe '#has_new_notifications? ' do
  let(:activity) {PublicActivity::Activity.create(recipient_id: user.id, readed: false)}
      it 'has_new_notifications?' do
        expect(described_class.new.has_new_notifications?).to eq true
      end
  end

end
