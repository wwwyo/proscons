FactoryBot.define do
  factory :like do
    association :user
    association :discussion
  end
end
