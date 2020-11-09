class DiscussionsController < ApplicationController
  def create
    discussion = Discussion.new(discussion_params)
    if discussion.valid?
      discussion.save
    end
  end

  private 
  def discussion_params
    params.require(:discussion).permit(:comment).merge(user_id: current_user.id, room_id: params[:room_id])
  end
end
