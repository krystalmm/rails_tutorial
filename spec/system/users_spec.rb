require 'rails_helper'

RSpec.describe type: :system do
  describe "access to users" do
    describe 'GET#new' do
      it 'returns http success' do
        visit signup_path
        expect(page).to have_css('h1', text: 'Sign up')
        expect(page).to have_title "Sign up | Ruby on Rails Tutorial Sample App"
      end
    end
  end
end

