FactoryBot.define do
  factory :ballot_form do
    question { Faker::Lorem.word }
    detail { Faker::Lorem.paragraph}
    name { Faker::Lorem.word }
    user_id { "1" }
  end
end
