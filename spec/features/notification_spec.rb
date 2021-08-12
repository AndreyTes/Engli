require 'rails_helper'

RSpec.feature "Notifications", type: :feature do
  let(:user) { create(:user) }
  before :each do
    sign_in user
  end

  describe 'Notifications' do
    let!(:phrase) { create(:phrase) }
    context "Phrase" do
      it "up"  do
        visit phrases_path
        click_link(href: vote_phrase_path(phrase, vote: "up"))
        expect(page).to have_content('Thanks for your vote')
        sign_in phrase.user
        visit notifications_path
        expect(page).to have_content('Liked your phrase')
      end
      it "down"  do
        visit phrases_path
        click_link(href: vote_phrase_path(phrase, vote: "down"))
        expect(page).to have_content('Thanks for your vote')
        sign_in phrase.user
        visit notifications_path
        expect(page).to have_content('Disliked your phrase')
      end
    end
    context "Example" do
      let!(:example) { create(:example, phrase: phrase) }
      it "up"  do
        visit phrase_path(phrase)
        click_link(href: vote_phrase_example_path(example.phrase, example , vote: 'up'))
        expect(page).to have_content('Thanks for your vote')
        sign_in example.user
        visit notifications_path
        expect(page).to have_content('Liked your example')
      end
      it "down"  do
        visit phrase_path(phrase)
        click_link(href: vote_phrase_example_path(example.phrase, example , vote: 'down'))
        expect(page).to have_content('Thanks for your vote')
        sign_in example.user
        click_link(href: read_all_notifications_path)
        expect(page).to have_content('Disliked your example')
      end
    end
  end

end