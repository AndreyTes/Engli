require 'rails_helper'

RSpec.feature "UsersShows", type: :feature do
  let(:user) { create(:user) }
  before :each do
    Capybara.current_driver = :selenium 
    sign_in user
  end

  context "Users list show" do
    it "success" do
      user
      visit users_path
      expect(page).to have_content("Listing users")
      expect(page).to have_content("#{user.username}")
    end
  end 
end