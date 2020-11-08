class RoomsController < ApplicationController
  before_action :room_name, only: [:index, :new, :show, :edit], if: :user_signed_in?

  def index
    @room = BallotBox.find_by(id: params[:ballot_box_id])
    @vote = Vote.find_by(user_id: current_user.id, ballot_box_id: params[:ballot_box_id])
  end

  private
  def room_name
    @rooms = current_user.user_rooms.includes(:room)
  end
end
