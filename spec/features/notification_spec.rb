require 'rails_helper'

RSpec.feature "Notifications", type: :feature do
  let(:user) { create(:user) }
  let(:phrase) { create(:phrase, user: user) }
  let(:example) {create(:example, phrase: phrase, user: user)}
  before :each do
    Capybara.current_driver = :selenium 
    sign_in user
  end

  describe 'Notifications' do
    context "Phrase" do
      let(:phrase) { create(:phrase) }
      it "up"  do
        phrase
        visit phrases_path
        click_link(href: vote_phrase_path(phrase, vote: "up"))
        expect(page).to have_content('Thanks for your vote')
        sign_in phrase.user
        visit notifications_path
        expect(page).to have_content('Liked your phrase')
      end
      it "down"  do
        phrase
        visit phrases_path
        click_link(href: vote_phrase_path(phrase, vote: "down"))
        expect(page).to have_content('Thanks for your vote')
        sign_in phrase.user
        visit notifications_path
        expect(page).to have_content('Disliked your phrase')
      end
    end
    context "Example" do
      let(:phrase) { create(:phrase) }
      let(:example) { create(:example, phrase: phrase) }
      it "up"  do
        phrase
        example
        visit phrase_path(phrase)
        click_link(href: phrase_example_vote_path(example.phrase, example , vote: 'up'))
        expect(page).to have_content('Thanks for your vote')
        sign_in example.user
        visit notifications_path
        expect(page).to have_content('Liked your example')
      end
      it "down"  do
        phrase
        example
        visit phrase_path(phrase)
        click_link(href: phrase_example_vote_path(example.phrase, example , vote: 'down'))
        expect(page).to have_content('Thanks for your vote')
        sign_in example.user
        click_link(href: read_all_notifications_path)
        expect(page).to have_content('Disliked your example')
      end
    end
  end

end