require 'rails_helper'

RSpec.describe ApplicationHelper, type: :system do
  describe 'index page' do
    it 'shows like_or_dislike_btn' do
      visit new_user_registration_path
      fill_in 'Name', with: 'Moses'
      fill_in 'Email', with: 'mosese@gmail.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_on 'Sign up'
      visit root_path
      fill_in 'Add New Post', with: 'My Post'
      click_on 'Save'
      expect(page).to have_content('Like!')
    end
  end
end
