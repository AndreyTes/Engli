require 'rails_helper'

RSpec.feature "PhraseShows", type: :feature do
  let(:user) { create(:user) }
  let(:phrase) { create(:phrase, user: user) }
  let(:example) {create(:example, phrase: phrase, user: user)}
  before :each do
    Capybara.current_driver = :selenium 
    sign_in user
  end

  context "create new example" do
    it "success" do
      phrase
      example
      visit phrase_path(phrase)
      fill_form(:example, {example: '00000000000' })
      click_button "Submit"
      expect(page).to have_content("Example has been created")
      expect(page).to have_content("00000000000")
    end
   
    it "fail" do
      phrase
      example
      visit phrase_path(phrase)
      fill_form(:example, {example: '' })
      click_button "Submit"
      expect(page).to have_content('Example can`t be created')
    end    
  end
  
  context "delete example" do
    it "success"  do
      phrase
      example
      visit phrase_path(phrase)
      message = accept_alert  do 
      click_link ( 'Delete' ) 
      end 
      expect(message).to eq("Are you sure?")
      expect(page).to have_content('Example has been deleted')
    end
   
    it "fail" do
      phrase
      example
      visit phrase_path(phrase)
      message = dismiss_confirm do 
      click_link ( 'Delete' ) 
      end 
      expect(message).to eq("Are you sure?")
      print page.html
      expect(page).to have_content example.example
    end    
  end 

  context "delete example another user in anoter post" do
    let(:phrase) { create(:phrase) }
    let(:example) { create(:example, phrase: phrase) }
    it "fail" do
      phrase
      example
      visit phrase_path(phrase)
      expect(page).to_not have_content ("Delete")
    end    
  end 
  context "delete example another user in your post" do
    let(:phrase) { create(:phrase, user: user ) }
    let(:example) { create(:example, phrase: phrase) }
    it "fail" do
      phrase
      example
      visit phrase_path(phrase)
      expect(page).to have_content ("Delete")
    end    
  end 

  context "vote example fail" do
    it "up fail"  do
      phrase
      example
      visit phrase_path(phrase)
      click_link(href: phrase_example_vote_path(example.phrase, example , vote: 'up'))
      expect(page).to have_content('You cant like/dislike yourself example')
    end
    it "down fail" do
      phrase
      example
      visit phrase_path(phrase)
      click_link(href: phrase_example_vote_path(example.phrase, example, vote: 'down'))
      expect(page).to have_content('You cant like/dislike yourself example')
     
    end    
  end 
  context "vote example success" do
    let(:phrase) { create(:phrase) }
    let(:example) { create(:example, phrase: phrase) }
    it "up success"  do
      phrase
      example
      visit phrase_path(phrase)
      click_link(href: phrase_example_vote_path(example.phrase, example , vote: 'up'))
      expect(page).to have_content('Thanks for your vote')
    end

    it "down success"  do
      phrase
      example
      visit phrase_path(phrase)
      click_link(href: phrase_example_vote_path(example.phrase, example, vote: 'down'))
      expect(page).to have_content('Thanks for your vote')
    end

    it "Double vote"  do
      phrase
      example
      visit phrase_path(phrase)
      click_link(href: phrase_example_vote_path(example.phrase, example, vote: 'up'))
      click_link(href: phrase_example_vote_path(example.phrase, example, vote: 'up'))
      expect(page).to have_content('You already voted that post')
    end
  end 

  describe 'Carma test example' do
    let(:phrase) { create(:phrase) }
    let(:example) { create(:example, phrase: phrase) }
      context "User vote up example, carma check " do
        it "up"  do
          phrase
          example
          visit phrase_path(phrase)
          click_link(href: phrase_example_vote_path(example.phrase, example , vote: 'up'))
          expect(page).to have_content('Thanks for your vote')
          visit user_path(user)
          expect(page).to have_content('USER CARMA: 1')
          visit user_path(example.user)
          expect(page).to have_content('USER CARMA: 2')
        end

        it "down"  do
          phrase
          example
          visit phrase_path(phrase)
          click_link(href: phrase_example_vote_path(example.phrase, example, vote: 'down'))
          expect(page).to have_content('Thanks for your vote')
          visit user_path(user)
          expect(page).to have_content('USER CARMA: 1')
          visit user_path(example.user)
          expect(page).to have_content('USER CARMA: -1')
        end
      end 
  end
end
