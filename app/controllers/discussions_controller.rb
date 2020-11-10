class DiscussionsController < ApplicationController
  def create
    @discussion = Discussion.new(discussion_params)
    if @discussion.save
      ActionCable.server.broadcast 'discussion_channel', content: @discussion
    end
  end

  private 
  def discussion_params
    params.require(:discussion).permit(:comment).merge(user_id: current_user.id, room_id: params[:room_id], vote_id: params[:discussion][:vote])
  end
end
