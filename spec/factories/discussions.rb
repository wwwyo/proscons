FactoryBot.define do
  factory :discussion do
    comment { Faker::Lorem.paragraph }
    vote_result { true }
    association :user
    association :room
  end
end
