require 'rails_helper'

RSpec.describe "UsersEdits", type: :system do
  let(:user) { FactoryBot.create(:user) }
  before do
    login_as(user)
    click_on 'Account'
    click_on 'Setting'
  end
  scenario 'it fails edit with wrong information' do
    fill_in 'edit-name', with: ' '
    fill_in 'edit-email', with: 'user@invalid'
    fill_in 'edit-password', with: 'foo'
    fill_in 'edit-confirmation', with: 'bar'
    click_on 'Save changes'
    aggregate_failures do
      expect(current_path).to eq user_path(user)
      expect(has_css?('.alert-danger')).to be_truthy
    end
  end

  scenario 'it succeeds edit with correct information' do
    fill_in 'edit-name', with: 'Foo Bar'
    fill_in 'edit-email', with: 'foo@bar.com'
    fill_in 'edit-password', with: ''
    fill_in 'edit-confirmation', with: ''
    click_on 'Save changes'
    aggregate_failures do
      expect(current_path).to eq user_path(user)
      expect(has_css?('.alert-success')).to be_truthy
    end
  end
end
