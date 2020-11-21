class LikesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    like = Like.new(user_id: current_user.id, discussion_id: params[:discussion_id])
    if like.save
      if Like.where(discussion_id: like.discussion_id).count == 10
        Vote.create(result: like.discussion.vote_result, user_id: current_user.id, ballot_box_id: params[:ballot_box_id])
      end
    end
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, discussion_id: params[:discussion_id])
    like.destroy
    if Like.where(discussion_id: like.discussion_id).count == 9
      vote = Vote.find_by(result: like.discussion.vote_result, user_id: current_user.id, ballot_box_id: params[:ballot_box_id])
      vote.destroy
    end
  end
end
