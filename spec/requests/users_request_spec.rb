require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "before_action: :logged_in_user" do
    let(:user) { FactoryBot.create(:user) }

    it 'redirects edit when not logged in' do
      get edit_user_path(user)
      expect(response).to redirect_to login_path
    end

    it 'redirects update when not logged in' do
      patch user_path(user), params: { user: { name: user.name, email: user.email } }
      expect(response).to redirect_to login_path
    end
  end

  describe "before_action: :correct_user" do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user, name: 'other_user', email: 'other@example.com') }

    before { log_in_as(other_user) }
    it 'redirects edit when logged in as wrong user' do
      get edit_user_path(user)
      expect(response).to redirect_to root_path
    end

    it 'redirects update when logged in as wrong user' do
      patch user_path(user), params: { user: { name: user.name, email: user.email } }
      expect(response).to redirect_to root_path
    end
  end

  describe "GET /users" do
    it 'redirects login when not logged in' do
      get users_path
      expect(response).to redirect_to login_url
    end
  end

end
