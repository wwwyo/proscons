class RoomsController < ApplicationController
  before_action :room_name, only: [:index], if: :user_signed_in?

  def index
    @room = BallotBox.find(params[:ballot_box_id])
    @vote = Vote.find_by(user_id: current_user.id, ballot_box_id: params[:ballot_box_id])
  end

  def destroy
    room = UserRoom.find_by(user_id: current_user.id, room_id: params[:id])
    if room.destroy
      redirect_to ballot_boxes_path
    else
      redirect_to action: :index
    end
  end

  private
  def room_name
    @user_rooms = current_user.user_rooms.includes(:room)
  end
end
