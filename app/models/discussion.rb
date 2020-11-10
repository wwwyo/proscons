class Discussion < ApplicationRecord
  belongs_to :user
  belongs_to :room
  belongs_to :vote
  
  validates :comment, presence: true
end
