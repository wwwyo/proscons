class Discussion < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  validates :comment, presence: true
  validates :vote_result, inclusion: {in: [true, false]}
end
