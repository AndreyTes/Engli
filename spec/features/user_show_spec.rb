require 'rails_helper'

RSpec.feature "UserShows", type: :feature do
  let(:user) { create(:user) }
  let(:phrase) { create(:phrase, user: user) }
  before :each do
    Capybara.current_driver = :selenium 
    sign_in user
  end

  context "update phrase" do
    it "success" do
      phrase
      visit edit_phrase_path(phrase)
      expect(page).to have_content("Edit Phrase")
      fill_form(:phrase, { phrase: 'cxcxcxcxcx' })
      click_button "Submit"
      expect(page).to have_content("Phrase has been updated")
    end
   
    it "fail" do
      visit edit_phrase_path(phrase)
      expect(page).to have_content("Edit Phrase")
      fill_form(:phrase, { phrase: "" })
      click_button "Submit"
      expect(page).to have_content("Phrase can`t be updated")
    end    
  end

  context "delete phrase" do
    it "success"  do
      phrase
      visit user_path(user)
      message = accept_alert  do 
      click_link ( 'Delete' ) 
      end 
      expect(message).to eq("Are you sure?")
      expect(page).to have_content('Phrase has been deleted')
    end
   
    it "fail" do
      phrase
      visit user_path(user)
      message = dismiss_confirm do 
      click_link ( 'Delete' ) 
      end 
      expect(message).to eq("Are you sure?")
      expect(page).to have_content phrase.phrase
    end    
  end 

  describe 'Carma test phrase' do
    let(:phrase) { create(:phrase) }
      context "User vote up post, carma check " do
        it "up"  do
          phrase
          visit phrases_path
          click_link(href: vote_phrase_path(phrase, vote: "up"))
          expect(page).to have_content('Thanks for your vote')
          visit user_path(user)
          expect(page).to have_content('USER CARMA: 1')
          visit user_path(phrase.user)
          expect(page).to have_content('USER CARMA: 4')
        end

        it "down"  do
          phrase
          visit phrases_path
          click_link(href: vote_phrase_path(phrase, vote: "down"))
          expect(page).to have_content('Thanks for your vote')
          visit user_path(user)
          expect(page).to have_content('USER CARMA: 1')
          visit user_path(phrase.user)
          expect(page).to have_content('USER CARMA: -2')
        end
      end 
  end
end
