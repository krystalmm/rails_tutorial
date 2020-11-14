require 'rails_helper'

RSpec.describe 'access to sessions', type: :request do
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

  describe 'remember me' do
    it "remembers the cookie when user checks the remember me box" do
      log_in_as(user)
      # expect(cookies[:remember_token]).to_not eq nil
      expect(cookies[:remember_token]).to eq assigns(:user).remember_token
    end

    it "does not remembers the cookie when user does not checks the remember me box" do
      log_in_as(user, remember_me: '0')
      expect(cookies[:remember_token]).to eq nil
    end
  end
end
