class DiscussionsController < ApplicationController
  before_action :authenticate_user!
  def create
    @discussion = Discussion.new(discussion_params)
    if @discussion.save
      ActionCable.server.broadcast 'discussion_channel', comment: @discussion.comment, nickname: @discussion.user.nickname, discussion_id: @discussion.id
    end
  end

  private 
  def discussion_params
    params.require(:discussion).permit(:vote_result, :comment ).merge(user_id: current_user.id, room_id: params[:room_id])
  end
end
