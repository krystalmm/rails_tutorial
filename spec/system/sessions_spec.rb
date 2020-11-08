require 'rails_helper'

describe 'access to sessions' do
  describe 'GET#new' do
    it 'returns http success' do
      visit login_path
      expect(page).to have_css('h1', text: 'Log in')
      expect(page).to have_title "Log in | Ruby on Rails Tutorial Sample App"
    end
  end
end
