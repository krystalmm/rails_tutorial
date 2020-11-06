FactoryBot.define do
  factory :user do
    name { "Example User" }
    email { "test1@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
  end
end
