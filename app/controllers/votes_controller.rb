class VotesController < ApplicationController
  def create
    vote = Vote.new(vote_params)
    if vote.valid?
      vote.save
      redirect_to "/ballot_boxes/:#{params[:ballot_box_id]}/rooms"
    else
      redirect_to "/ballot_boxes/:#{params[:ballot_box_id]}"
    end
  end

  private
  def vote_params
    params.require(:vote).permit(:result).merge(user_id: current_user.id, ballot_box_id: params[:ballot_box_id])
  end
end
