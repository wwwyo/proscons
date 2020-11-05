class BallotTag < ApplicationRecord
  belongs_to :ballot_box
  belongs_to :tag
end
