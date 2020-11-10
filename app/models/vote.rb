class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :ballot_box
  has_many :discussions
  validates :result, inclusion: {in: [true, false]}
end
