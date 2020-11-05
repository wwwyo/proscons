FactoryBot.define do
  factory :user do
    nickname { Faker::Lorem.word }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
  end
end