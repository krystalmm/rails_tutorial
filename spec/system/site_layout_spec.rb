require 'rails_helper'

describe "Site layout", type: :system do
  context "layout links" do
    before { visit root_path }

    it 'has links sach as root_path, help_path and about_path' do
      # Homeへのリンクは２つあるけどそのうちの１つはロゴの部分だから'Home'じゃなくてnilにする！
      expect(page).to have_link nil, href: root_path, count: 2
      expect(page).to have_link 'Help', href: help_path
      expect(page).to have_link 'About', href: about_path
      expect(page).to have_link 'Contact', href: contact_path  
      expect(page).to have_link 'Sign up now!', href: signup_path 
    end
  end
end

