class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]
  before_action :room_name, if: :user_signed_in?
  before_action :search
  def index
    @ballot_room = BallotBox.find(params[:ballot_box_id])
    @discussion = Discussion.new
    @discussions = @ballot_room.room.discussions
    @vote = Vote.find_by(user_id: current_user.id, ballot_box_id: params[:ballot_box_id]) if user_signed_in?
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
    @user_rooms = current_user.user_rooms.includes(:room).order(created_at: :desc)
  end

  def search
    @search = Tag.ransack(params[:q])
  end
end