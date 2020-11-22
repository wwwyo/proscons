class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :ballot_box
  validates :result, inclusion: { in: [true, false] }

  def self.change(vote)
    vote.result = if vote.result
      0
    else
      1
    end
    vote.save
  end
end
