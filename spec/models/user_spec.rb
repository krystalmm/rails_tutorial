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

  it "name should not be too long" do
    user_a.name = "a" *51
    expect(user_a).not_to be_valid
  end

  it "email should not be too long" do
    user_a.email = "a" *244 + "@example.com"
    expect(user_a).not_to be_valid
  end
 
  it "email validation should accept valid adresses" do
    valid_addresses = %w[ user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn ]
    valid_addresses.each do | valid_address |
      user_a.email = valid_address
      expect(user_a).to be_valid, "#{valid_address.inspect} should be valid"
    end
  end

  it "email validation should reject invalid addresses" do
    invalid_addresses = %w[ user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com ]
    invalid_addresses.each do | invalid_address |
      user_a.email = invalid_address
      expect(user_a).to_not be_valid, "#{invalid_address.inspect} should be invalid"
    end
  end

  it "email addresses should be unique" do
    duplicate_user = user_a.dup
    duplicate_user.email = user_a.email.upcase
    expect(duplicate_user).to_not be_valid
  end

  it "password should be present (nonblank) " do
    user_a.password = user_a.password_confirmation = " " * 6
    expect(user_a).to_not be_valid
  end

  it "password should have a minimum length" do
    user_a.password = user_a.password_confirmation = "a" * 5
    expect(user_a).to_not be_valid
  end

  it "returns false for a user with nil digest" do
    expect(user_a.authenticated?(:remember,'')).to be_falsey
  end

  describe "dependent: :destroy" do
    before do 
      user_a.save
      user_a.microposts.create!(content: "Lorem ipsum")
    end

    it 'succeeds' do
      expect do
        user_a.destroy
      end.to change(Micropost, :count).by(-1)
    end
  end

  describe "follow and unfollow" do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }

    before { user.follow(other_user) }

    describe "follow" do
      it "succeeds" do
        expect(user.following?(other_user)).to be_truthy
      end
    end

    describe "followers" do
      it "succeeds" do
        expect(other_user.followers.include?(user)).to be_truthy
      end
    end

    describe "unfollow" do
      it "succeeds" do
        user.unfollow(other_user)
        expect(user.following?(other_user)).to be_falsey
      end
    end
  end
end

