class BallotBox < ApplicationRecord
  belongs_to :user
  has_many :tags, through: :ballot_tags
  has_many :ballot_tags, dependent: :destroy
end
