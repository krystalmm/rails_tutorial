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

  describe "index" do
    let!(:user) { FactoryBot.create(:user) }

    before do
      visit login_path
      login_as(user)
      visit users_path
    end

    it 'returns http success' do
      expect(page).to have_css('h1', text: 'All users')
      expect(page).to have_title "All users | Ruby on Rails Tutorial Sample App"
    end

    describe "pagination" do
      before(:all) { 30.times { FactoryBot.create(:other_users) } }
      after(:all) { User.delete_all }

      it 'should have pagination' do
        expect(page).to have_css('div.pagination')
      end

      it 'should list each user' do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end
  end

  describe "GET#show" do
    let!(:user) { FactoryBot.create(:user) }
    
    before do
      visit login_path
      login_as(user)
      visit user_path(user)
    end

    describe "users profile" do
      before(:all) { 30.times { FactoryBot.create(:many_content) } }
      after(:all) { Micropost.delete_all }

      it 'profile display' do
        expect(page).to have_current_path "/users/#{user.id}"
        expect(page).to have_title "#{user.name}"
        expect(page).to have_css('h1', text: "#{user.name}")
        expect(page.body).to match user.microposts.count.to_s
      end

      it 'should list each micropost' do
        user.microposts.paginate(page: 1).each do |micropost|
          expect(page).to have_selector('li', text: user.micropost.content)
        end
      end
    end
  end 
end

