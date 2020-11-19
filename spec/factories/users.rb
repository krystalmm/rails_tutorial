FactoryBot.define do
  factory :user do
    name { "Example User" }
    email { "test1@example.com" }
    password { "password" }
    password_confirmation { "password" }
    password_digest {  User.digest('password')  }

    # 他人
    factory :other_users do
      name { Faker::Name.name }
      email { Faker::Internet.email }
    end
  end
end

