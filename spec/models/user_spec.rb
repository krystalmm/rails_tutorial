require 'rails_helper'

RSpec.describe User, type: :model do
  
  let(:user_a) { FactoryBot.create(:user) }

  it "should be valid" do  
    expect(user_a).to be_valid
  end

  it "name should be present" do 
    user_a.name = " "
    expect(user_a).not_to be_valid
  end

  it "email should be present" do
    user_a.email = " "
    expect(user_a).not_to be_valid
  end

end
