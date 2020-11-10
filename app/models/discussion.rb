class Discussion < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  validates :comment, presence: true
  validates :vote_result, presence: true
end
