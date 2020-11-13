require 'rails_helper'

describe 'access to sessions', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  describe 'POST#create' do
    it 'log in and redirect to detail page' do
      post login_path, params: { session: { email: user.email, password: user.password } }
      expect(response).to redirect_to user_path(user)
      expect(is_logged_in?).to be_truthy # ログインしているかのテスト
    end
  end

  describe 'DELETE#destroy' do
    it 'log out and redirect to root page' do
      post login_path, params: { session: { email: user.email, password: user.password } }
      delete logout_path
      expect(response).to redirect_to root_url
      expect(is_logged_in?).to be_falsey # ログアウトしているかのテスト
    end

    it 'succeeds logout when user logs out on multiple tabs' do
      delete logout_path
      expect(response).to redirect_to root_url
      expect(is_logged_in?).to be_falsey
    end
  end
end
