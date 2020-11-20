require 'rails_helper'

describe 'users signup', type: :system do
  describe 'form test' do
    # 無効な値が入力されたとき
    context "invalid signup information" do
      before do
        visit signup_path
        fill_in 'form-name', with: " "
        fill_in 'form-email', with: " "
        fill_in 'form-password', with: " "
        fill_in 'form-confirmation', with: " "
        click_button 'Create my account'
      end 

      it 'gets an errors' do
        expect(page).to have_selector('#error_explanation')
      end

      it 'render to /signup url' do
        expect(page).to have_current_path '/signup'
      end

    end

    # 有効な値が入力されたとき
    context "valid signup infomation" do
      before do 
        visit signup_path
        fill_in 'form-name', with: "Example User"
        fill_in 'form-email', with: "user@example.com"
        fill_in 'form-password', with: "password"
        fill_in 'form-confirmation', with: "password"
        click_button 'Create my account'
      end

      it 'gets an flash message' do
        expect(page).to have_selector('.alert-info', text: "Please check your email to activate your account.")
      end
    end

  end
end
