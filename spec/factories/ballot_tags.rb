FactoryBot.define do
  factory :ballot_tag do
    association :ballot_box
    association :tag
  end
end
