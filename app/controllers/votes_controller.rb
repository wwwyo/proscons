class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    vote = Vote.new(vote_params)
    if vote.save
      UserRoom.create(user_id: current_user.id, room_id: vote.ballot_box.room.id)
      redirect_to ballot_box_rooms_path(params[:ballot_box_id])
    end
  end

  def update
    vote = Vote.find_by(user_id: current_user.id, ballot_box_id: params[:ballot_box_id])
    if !vote.nil?
      vote.result = if vote.result
                      0
                    else
                      1
                    end
      vote.save
      redirect_to ballot_box_rooms_path(params[:ballot_box_id])
    else
      redirect_to ballot_box_path(params[:ballot_box_id])
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:result).merge(user_id: current_user.id, ballot_box_id: params[:ballot_box_id])
  end
end
