require 'rails_helper'

RSpec.describe 'Discussions', type: :request do
  before do
    user_room = FactoryBot.create(:user_room)
    @user = user_room.user
    @room = user_room.room
    @ballot_box = @room.ballot_box
  end

  describe 'POST #create' do
    context 'ログインしたユーザーがコメントする時' do
      before do
        sign_in @user
      end
      it '正常にレスポンスが返ってくる' do
        post ballot_box_room_discussions_path(@ballot_box, @room), params: { discussion: { vote_result: true, comment: Faker::Lorem.paragraph } }
        expect(response.status).to eq 204
      end
    end
    context 'ログインしていない時' do
      it 'リダイレクトのレスポンスが返ってくる' do
        post ballot_box_room_discussions_path(@ballot_box, @room)
        expect(response.status).to eq 302
      end
      it 'リダイレクト先が:sign_in' do
        post ballot_box_room_discussions_path(@ballot_box, @room)
        expect(response.header).to redirect_to new_user_session_path
      end
    end
  end
end
