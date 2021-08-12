require 'rails_helper'

RSpec.feature "Registration", type: :feature do
  let(:user) { create(:user) }

  context "Users registration" do
    it "success" do
      visit ("/auth/register/sign_up")
       fill_form(:resource, { username: '111', email: "d@d.com", password: "123456", password_confirmation: "123456"  })
       click_button "Sign up" 
       expect(page).to have_content("Welcome! You have signed up successfully.")
    end
  end 
end