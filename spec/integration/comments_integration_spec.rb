require 'rails_helper'
require 'spec_helper'

RSpec.describe CommentsController, type: :feature do
  context 'Comments management' do
    before :each do
      user = User.create(id: '1', name: 'kender', email: 'kender@mail.com', password: '123456')
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
      visit root_path
      fill_in 'post_content', with: 'content for the posts'
      click_button 'Save'
    end
    it 'creates comment for a post' do
      visit root_path
      fill_in 'comment_content', with: 'new comment'
      click_button 'Comment'
      expect(page).to have_content('Comment was successfully created')
    end
  end
end
