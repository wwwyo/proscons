class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :ballot_box
  validates :result, inclusion: { in: [true, false] }
end
