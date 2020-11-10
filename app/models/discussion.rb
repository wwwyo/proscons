class Discussion < ApplicationRecord
  belongs_to :user
  belongs_to :room
  belongs_to :vote
end
