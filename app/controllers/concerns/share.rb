module Share
  extend ActiveSupport::Concern

  def share_content
    @user_rooms = current_user.user_rooms.includes(:room).order(created_at: :desc) if user_signed_in?
    @search = Tag.ransack(params[:q])
  end
end