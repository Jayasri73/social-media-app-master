require 'rails_helper'
require 'capybara/rspec'

RSpec.describe LikesController, type: :feature do
  context 'Likes management' do
    before :each do
      user = User.create(id: '1', name: 'Peter', email: 'peter@example.com', password: 'password')
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
      visit root_path
      fill_in 'post_content', with: 'Post testing'
      click_button 'Save'
    end
    it 'likes a post' do
      visit root_path
      click_link 'Like'
      expect(page).to have_content('You liked a post.')
    end
    it 'dislikes a post' do
      visit root_path
      click_link 'Like'
      sleep(2)
      click_link 'Dislike'
      expect(page).to have_content('You disliked a post')
    end
  end
end
