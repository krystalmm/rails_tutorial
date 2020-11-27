FactoryBot.define do
  factory :micropost do
    content { "micropost test" }
    created_at { 10.minutes.ago }
    # 関連付けされてあるUserオブジェクトを自動で生成してくれる！
    association :user

    trait :yesterday do
      content { "yesterday" }
      created_at { 1.day.ago }
    end

    trait :day_before_yesterday do
      content { "day_before_yesterday" }
      created_at { 2.days.ago }
    end

    trait :now do
      content { "now!" }
      created_at { Time.zone.now }
    end

    factory :many_content do
      content { Faker::Lorem.sentence(5) }
      created_at { 42.days.ago }
    end
  end
end
