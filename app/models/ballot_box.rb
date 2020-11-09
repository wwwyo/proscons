class BallotBox < ApplicationRecord
  belongs_to :user
  has_many :tags, through: :ballot_tags
  has_many :ballot_tags, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_one :room, dependent: :destroy
end
