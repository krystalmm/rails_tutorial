require 'rails_helper'

RSpec.describe "MicropostsInterfaces", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:micropost) { FactoryBot.create(:micropost) }

  before do
    34.times do
      content = Faker::Lorem.sentence(word_count: 5)
      user.microposts.create!(content: content)
    end
  end

  scenario "micropost interface" do
    login_as(user)
    click_on "Home"

    # 無効な送信
    click_on "Post"
    expect(has_css?('.alert-danger')).to be_truthy

    # 正しいページネーションリンク
    visit root_path
    click_on "2"
    expect(URI.parse(current_url).query).to eq "page=2"

    # 有効な送信
    valid_content = "This micropost really ties the room together"
    fill_in "new-micropost-content", with: valid_content
    expect do
      click_on "Post"
      expect(current_path).to eq root_path
      expect(has_css?('.alert-success')).to be_truthy
    end.to change(Micropost, :count).by(1)

    # 投稿を削除する
    visit root_path
    expect do
      page.accept_confirm do
        all('ol li')[0].click_on "delete"
        page.driver.browser.switch_to.alert.accept
      end
      expect(current_path).to eq root_path
      expect(has_css?('.alert-success')).to be_truthy
    end.to change(Micropost, :count).by(-1)

    # 違うユーザーのプロフィールにアクセス（削除リンクがないことを確認）
    visit user_path(micropost.user)
    expect(page).to_not have_link "delete"
  end
end

