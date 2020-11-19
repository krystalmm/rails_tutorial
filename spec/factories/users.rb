FactoryBot.define do
  factory :user do
    name { "Example User" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    password_digest {  User.digest('password')  }

    # FactoryBot.create(:user, :admin)の形で呼び出せる、管理者権限を持つテストユーザー
    trait :admin do
      admin { true }
    end

    # 他人
    factory :other_users do
      name { Faker::Name.name }
      email { Faker::Internet.email }
    end

  end
end

