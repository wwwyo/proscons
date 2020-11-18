FactoryBot.define do
  factory :ballot_box do
    question { Faker::Lorem.word }
    detail { Faker::Lorem.paragraph }
    association :user
  end
end
