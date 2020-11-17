module TestHelper
  # テストユーザーがログイン中の場合にtrueを返す
  def is_logged_in?
    !session[:user_id].nil? 
  end

  # テストユーザーとしてログインする
  def log_in_as(user)
    session[:user_id] = user.id 
  end

  # テストユーザーとしてログインする
  def log_in_as(user, remember_me: '1')
	  post login_path, params: { session: { email: user.email, password: user.password, remember_me: remember_me } }
  end
end

module SystemHelper
  def login_as(user)
    visit login_path
    fill_in 'login-email', with: user.email
    fill_in 'login-password', with: user.password
    click_button 'Log in'
  end
end

RSpec.configure do |config|
  config.include TestHelper
  config.include SystemHelper
end


