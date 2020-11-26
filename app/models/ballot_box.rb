class BallotBox < ApplicationRecord
  belongs_to :user
  has_many :tags, through: :ballot_tags
  has_many :ballot_tags, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_one :room, dependent: :destroy

  def self.search(search)
    BallotBox.group('ballot_boxes.id').joins(:ballot_tags).where(ballot_tags: { tag_id: search.result.ids })
  end
end
