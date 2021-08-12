require 'rails_helper'

RSpec.feature "Phrases", type: :feature do
  let(:user) { create(:user) }
  let(:phrase) { create(:phrase, user: user) }
  before :each do
    sign_in user
  end
  
  context "Redirect to phrase" do
    it "success" do
      phrase
      visit phrases_path
      click_link(href: phrase_path(phrase))
      expect(page).to have_content("Author: #{user.username}")
    end
  end 
  
  context "Redirect to user" do
    it "success" do
      phrase
      visit phrases_path
      click_link(href: user_path(phrase.user))
      expect(page).to have_content("Username: #{user.username}")
    end
  end 

  context "create new phrase" do
    it "success" do
      visit new_phrase_path
      fill_form(:phrase, { phrase: '111', translation: '222', category: Phrase.categories.keys[0] })
      fill_form(:example, {example: '333' })
      click_button "Submit"
      expect(page).to have_content("Phrase has been created")
    end
   
    it "fail" do
      visit new_phrase_path
      fill_form(:phrase, { phrase: '111', translation: '222', category: Phrase.categories.keys[0] })
      click_button "Submit"
      expect(page).to have_content("Phrase can`t be created") 
    end    
  end  
  
  context "vote phrase fail" do
    it "up fail"  do
      phrase
      visit phrases_path
      click_link(href: vote_phrase_path(phrase, vote: "up"))
      expect(page).to have_content('You cant like/dislike yourself phrase')
    end
    it "down fail" do
      phrase
      visit phrases_path
      click_link(href: vote_phrase_path(phrase, vote: "down"))
      expect(page).to have_content('You cant like/dislike yourself phrase')
    end    
  end 
  context "vote phrase success" do
    let(:phrase) { create(:phrase) }
    it "up success"  do
      phrase
      visit phrases_path
      click_link(href: vote_phrase_path(phrase, vote: "up"))
      expect(page).to have_content('Thanks for your vote')
    end

    it "down success"  do
      phrase
      visit phrases_path
      click_link(href: vote_phrase_path(phrase, vote: "down"))
      expect(page).to have_content('Thanks for your vote')
    end

    it "Double vote"  do
      phrase
      visit phrases_path
      click_link(href: vote_phrase_path(phrase, vote: "up"))
      click_link(href: vote_phrase_path(phrase, vote: "up"))
      expect(page).to have_content('You already voted that post')
    end
  end 
end