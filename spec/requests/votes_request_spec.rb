require 'rails_helper'

RSpec.describe "Votes", type: :request do
  before do
    @user = FactoryBot.create(:user)
    room = FactoryBot.create(:room)
    @ballot_box = room.ballot_box
  end

  describe 'POST #create' do
    context 'ログインしている時' do
      before do
        sign_in @user
      end
      it 'リダイレクトのレスポンスが返ってくる' do
        post ballot_box_votes_path(@ballot_box), params: {vote: {result: 1}}
        expect(response.status).to eq 302
      end
      it 'リダイレクト先が"room#index"' do
        post ballot_box_votes_path(@ballot_box), params: {vote: {result: 1}}
        expect(response.header).to redirect_to ballot_box_rooms_path(@ballot_box)
      end
    end
    context 'ログインしていない時' do
      it 'リダイレクトのレスポンスが返ってくる' do
        post ballot_box_votes_path(@ballot_box), params: {vote: {result: 1}}
        expect(response.status).to eq 302
      end
      it 'リダイレクト先が:sign_in' do
        post ballot_box_votes_path(@ballot_box), params: {vote: {result: 1}}
        expect(response.header).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PUTCH #update' do
    before do
      @vote = Vote.create(result: 1, user_id: @user.id, ballot_box_id: @ballot_box.id)
    end
    context 'ログインしているかつ、投票者である時' do
      before do
        sign_in @user
      end
      it 'リダイレクトのレスポンスが返ってくる' do
        patch  ballot_box_vote_path(@ballot_box, @vote)
        expect(response.status).to eq 302
      end
      it 'リダイレクト先が"room#index"' do
        patch  ballot_box_vote_path(@ballot_box, @vote)
        expect(response.header).to redirect_to ballot_box_rooms_path(@ballot_box)
      end
    end
    context 'ログインしているが投票者本人ではない時' do
      before do
        @user = FactoryBot.create(:user)
        sign_in @user
      end
      it 'リダイレクトのレスポンスが返ってくる' do
        patch  ballot_box_vote_path(@ballot_box, @vote)
        expect(response.status).to eq 302
      end
      it 'リダイレクト先が"ballot_box#show"' do
        patch  ballot_box_vote_path(@ballot_box, @vote)
        expect(response.header).to redirect_to ballot_box_path(@ballot_box)
      end
    end
    context 'ログインしていない時' do
      it 'リダイレクトのレスポンスが返ってくる' do
        patch  ballot_box_vote_path(@ballot_box, @vote)
        expect(response.status).to eq 302
      end
      it 'リダイレクト先が:sign_in' do
        patch  ballot_box_vote_path(@ballot_box, @vote)
        expect(response.header).to redirect_to new_user_session_path
      end
    end
  end
end
