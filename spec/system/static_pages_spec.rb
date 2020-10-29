require 'rails_helper'

  describe "GET #home" do
    it "returns http success" do
      visit '/static_pages/home'
      expect(page).to have_css('h1', text: 'Sample App')
      expect(page).to have_title "Home | Ruby on Rails Tutorial Sample App"
    end
  end

  describe "GET #help" do
    it "returns http success" do
      visit '/static_pages/help'
      expect(page).to have_css('h1', text: 'Help')
      expect(page).to have_title "Help | Ruby on Rails Tutorial Sample App"
    end
  end

  describe "GET #about" do
    it "returns http success" do
      visit 'static_pages/about'
      expect(page).to have_css('h1', text: 'About')
      expect(page).to have_title "About | Ruby on Rails Tutorial Sample App"
    end
  end

