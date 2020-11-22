module Share
  extend ActiveSupport::Concern

  def share_content
    @user_rooms = UserRoom.preload(room: :ballot_box).where(user_id: current_user.id).order(created_at: :desc) if user_signed_in?
    @search = Tag.ransack(params[:q])
  end
end