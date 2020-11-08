class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :ballot_box

  validates :result, presence: true
end
