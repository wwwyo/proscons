class LikesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    Like.create(user_id: current_user.id, discussion_id: params[:discussion_id])
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, discussion_id: params[:discussion_id])
    like.destroy
  end
end
