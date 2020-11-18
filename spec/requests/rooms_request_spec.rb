require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @ballot_box = FactoryBot.create(:ballot_box)
    @room = Room.create(ballot_box_id: @ballot_box.id)
    UserRoom.create(user_id: @user.id, room_id: @room.id)
  end
  describe 'GET #index' do
    it '正常にレスポンスが返ってくる' do
      get ballot_box_rooms_path(@ballot_box)
      expect(response.status).to eq 200
    end
  end

  describe 'DELETE #destroy' do
    context 'ログインしている時' do
      before do
        sign_in @user
      end
      it 'リダイレクトのレスポンスが返ってくる' do
        delete ballot_box_room_path(@ballot_box, @room)
        expect(response.status).to eq 302
      end
      it 'リダイレクト先が"ballor_boxes#index"' do
        delete ballot_box_room_path(@ballot_box, @room)
        expect(response.header).to redirect_to ballot_boxes_path
      end
    end
    context 'ログインしていない時' do
      it 'リダイレクトのレスポンスが返ってくる' do
        delete ballot_box_room_path(@ballot_box, @room)
        expect(response.status).to eq 302
      end
      it 'リダイレクト先が:sign_in' do
        delete ballot_box_room_path(@ballot_box, @room)
        expect(response.header).to redirect_to new_user_session_path
      end
    end
  end

end
