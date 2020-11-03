require 'rails_helper'

describe "GET #home" do
  it "returns http success" do
    visit root_path
    expect(page).to have_css('h1', text: 'Sample App')
    expect(page).to have_title("Ruby on Rails Tutorial Sample App", exact: true)
  end

end

describe "GET #help" do
  it "returns http success" do
    visit help_path
    expect(page).to have_css('h1', text: 'Help')
    expect(page).to have_title "Help | Ruby on Rails Tutorial Sample App"
  end
end

describe "GET #about" do
  it "returns http success" do
    visit about_path
    expect(page).to have_css('h1', text: 'About')
    expect(page).to have_title "About | Ruby on Rails Tutorial Sample App"
  end
end

describe "GET #contact" do
  it "returns http success" do
    visit contact_path
    expect(page).to have_css('h1', text: 'Contact')
    expect(page).to have_title "Contact | Ruby on Rails Tutorial Sample App"
  end
end

