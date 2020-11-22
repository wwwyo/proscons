class Like < ApplicationRecord
  belongs_to :user
  belongs_to :discussion

  def self.like_10_create(discussion, ballot_box_id)
    if Like.where(discussion_id: discussion.id).count == 10
      Vote.create(result: discussion.vote_result, user_id: discussion.user_id, ballot_box_id: ballot_box_id)
    end
  end

  def self.like_10_destroy(discussion, ballot_box_id)
    if Like.where(discussion_id: discussion.id).count == 9
      Vote.find_by(result: discussion.vote_result, user_id: discussion.user_id, ballot_box_id: ballot_box_id).destroy
    end
  end
end
