class VotesController < ApplicationController
  def create
    vote = Vote.new(vote_params)
    if vote.valid?
      vote.save
      redirect_to root_path
    else
      render "ballot_boxes/show"
    end
  end

  private
  def vote_params
    params.require(:vote).permit(:result).merge(user_id: current_user.id, ballot_box_id: params[:ballot_box_id])
  end
end
