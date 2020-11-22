class LikesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    like = Like.new(user_id: current_user.id, discussion_id: params[:discussion_id])
    if like.save
      Like.like_10_create(like.discussion, params[:ballot_box_id])
    end
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, discussion_id: params[:discussion_id])
    if like.destroy
      Like.like_10_destroy(like.discussion, params[:ballot_box_id])
    end
  end
end
