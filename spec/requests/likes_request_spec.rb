require 'rails_helper'

RSpec.describe "Likes", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @ballot_box = FactoryBot.create(:ballot_box)
    @room = Room.create(ballot_box_id: @ballot_box.id)
    @discussion = Discussion.create(comment: "abc", vote_result: true, user_id: @user.id, room_id: @room.id)
  end
  describe 'POST #create' do
    context 'ログインしたユーザーがいいねをつける時' do
      before do
        sign_in @user
      end
      it '正常にレスポンスが返ってくる' do
        post ballot_box_room_discussion_likes_path(@ballot_box, @room, @discussion)
        expect(response.status).to eq 204
      end
    end
    context 'ログインしていない時' do
      it 'リダイレクトのレスポンスが返ってくる' do
        post ballot_box_room_discussion_likes_path(@ballot_box, @room, @discussion)
        expect(response.status).to eq 302
      end
      it 'リダイレクト先が:sign_in' do
        post ballot_box_room_discussion_likes_path(@ballot_box, @room, @discussion)
        expect(response.header).to redirect_to new_user_session_path
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @like = Like.create(user_id: @user.id, discussion_id: @discussion.id)
    end
    context 'ログインしたユーザーが自分のつけたいいねを削除する時' do
      before do
        sign_in @user
      end
      it '正常にレスポンスが返ってくる' do
        delete ballot_box_room_discussion_like_path(@ballot_box, @room, @discussion, @like)
        expect(response.status).to eq 204
      end
    end
    context 'ログインしていない時' do
      it 'リダイレクトのレスポンスが返ってくる' do
        delete ballot_box_room_discussion_like_path(@ballot_box, @room, @discussion, @like)
        expect(response.status).to eq 302
      end
      it 'リダイレクト先が:sign_in' do
        delete ballot_box_room_discussion_like_path(@ballot_box, @room, @discussion, @like)
        expect(response.header).to redirect_to new_user_session_path
      end
    end
  end
end
