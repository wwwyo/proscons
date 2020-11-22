class RoomsController < ApplicationController
  include Share

  before_action :authenticate_user!, only: [:destroy]
  before_action :share

  def index
    @ballot_room = BallotBox.find(params[:ballot_box_id])
    @discussion = Discussion.new
    @discussions = @ballot_room.room.discussions.includes(:user)
    if user_signed_in?
      @vote = Vote.find_by(user_id: current_user.id, ballot_box_id: @ballot_room.id)
      return redirect_to ballot_box_path(@ballot_room.id) if @vote.nil?
      @user_rooms.where(room_id: @ballot_room.room.id).first_or_create
    end
  end

  def destroy
    room = UserRoom.find_by(user_id: current_user.id, room_id: params[:id])
    redirect_to ballot_boxes_path if room.destroy
  end

  private

  def share
    share_content
  end
end
