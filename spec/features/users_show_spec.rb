require 'rails_helper'

RSpec.feature "UsersShows", type: :feature do
  let!(:user) { create(:user) }
  before :each do
    sign_in user
  end

  context "Users list show" do
    it "success" do
      visit users_path
      expect(page).to have_content("Listing users")
      expect(page).to have_content("#{user.username}")
    end
  end 
end