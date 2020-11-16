class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    vote = Vote.new(vote_params)
    if vote.valid?
      vote.save
      UserRoom.create(user_id: current_user.id, room_id: vote.ballot_box.room.id)
      redirect_to "/ballot_boxes/#{params[:ballot_box_id]}/rooms"
    else
      redirect_to "/ballot_boxes/#{params[:ballot_box_id]}"
    end
  end

  def update
    vote = Vote.find(params[:id])
    if vote.result
      vote.result = 0
    else
      vote.result = 1
    end
    vote.save
    redirect_to "/ballot_boxes/#{params[:ballot_box_id]}/rooms"
  end

  private
  def vote_params
    params.require(:vote).permit(:result).merge(user_id: current_user.id, ballot_box_id: params[:ballot_box_id])
  end
end
