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

    it 'redirects delete when not logged in' do
      delete user_path(user)
      expect(response).to redirect_to login_url
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

  describe "GET /users/:id admin" do
    let(:user) { FactoryBot.create(:user) }
    it 'should not allow the admin attribute to be edited via the web' do
      log_in_as(user)
      expect(user).not_to be_admin
      patch user_path(user), params: { user:  { password: user.password, password_confirmation: user.password, admin: true }  }
      expect(user.reload).not_to be_admin
    end
  end

  describe "delete /users/:id" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:admin_user) { FactoryBot.create(:user, :admin) }

    it 'fails when not admin' do
      log_in_as(user)
      aggregate_failures do
        expect do
          delete user_path(admin_user)
        end.to change(User, :count).by(0)
        expect(response).to redirect_to root_url
      end
    end

    it 'succeeds when user is administrator' do
      log_in_as(admin_user)
      aggregate_failures do
        expect do
          delete user_path(user)
        end.to change(User, :count).by(-1)
        expect(response).to redirect_to users_url
      end
    end
  end

end
