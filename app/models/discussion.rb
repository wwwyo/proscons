class Discussion < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :likes, dependent: :destroy
  
  validates :comment, presence: true
  validates :vote_result, inclusion: {in: [true, false]}
end
