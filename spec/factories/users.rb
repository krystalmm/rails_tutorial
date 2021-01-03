FactoryBot.define do
  factory :user do
    name { "Example User" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    password_digest {  User.digest('password')  }
    activated { true }
    activated_at { Time.zone.now }
 
    # FactoryBot.create(:user, :admin)の形で呼び出せる、管理者権限を持つテストユーザー
    trait :admin do
      admin { true }
      activated { true }
      activated_at { Time.zone.now }
    end

    trait :no_activated do
      activated { false }
      activated_at { nil }
    end

    trait :with_microposts do
      after(:create) { |user| create_list(:micropost, 5, user: user) }
    end

    # 他人
    factory :other_users do
      name { Faker::Name.name }
      email { Faker::Internet.email }
      activated { true }
      activated_at { Time.zone.now }
    end

    factory :micropost_user do
      name { "micro" }
      sequence(:email) { |n| "micropost-#{n}@example.com" }
      password { "password" }
      password_digest { User.digest('password') }
      activated { true }
      activated_at { Time.zone.now }
    end

  end
end

