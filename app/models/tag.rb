class Tag < ApplicationRecord
  has_many :ballot_boxes, through: :ballot_tags
  has_many :ballot_tags, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def self.add_tag(tags_params, ballot_box_id)
    tags_params.each do |name|
      tag = Tag.where(name: name[1]).first_or_create
      BallotTag.create(ballot_box_id: ballot_box_id, tag_id: tag.id)
    end
  end
end
