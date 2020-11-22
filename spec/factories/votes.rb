FactoryBot.define do
  factory :vote do
    result { '1' }
    association :user
    association :ballot_box
  end
end
