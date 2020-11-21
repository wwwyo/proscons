require 'rails_helper'

RSpec.describe "いいね作成機能", type: :system do
  before do
    @discussion = FactoryBot.create(:discussion)
    @user = @discussion.user
    @room = @discussion.room
    @ballot_box = @room.ballot_box
    Vote.create(result: @discussion.vote_result, user_id: @user.id, ballot_box_id: @ballot_box.id)
  end
  context 'いいねをつけることができる' do
    it 'ログインしているユーザー' do
      sign_in(@user)
      visit ballot_box_rooms_path(@ballot_box)
      expect{
        sleep 1
        find('.like').click
        sleep 0.5
      }.to change { Like.count }.by(1)
      expect(current_path).to eq ballot_box_rooms_path(@ballot_box)
    end
  end
  context 'いいねをつけることができない' do
    it 'ログインしていないユーザー' do
      visit ballot_box_rooms_path(@ballot_box)
      expect{
        sleep 1
        find('.like').click
        sleep 0.5
      }.to change { Like.count }.by(0)
    end
  end
end

RSpec.describe "いいね削除機能", type: :system do
  before do
    @like = FactoryBot.create(:like)
    @user = @like.user
    @room = @like.discussion.room
    @ballot_box = @room.ballot_box
    Vote.create(result: @like.discussion.vote_result, user_id: @user.id, ballot_box_id: @ballot_box.id)
  end
  context 'いいねを削除できる' do
    it 'ログインしているユーザー' do
      sign_in(@user)
      visit ballot_box_rooms_path(@ballot_box)
      expect{
        sleep 1
        find('.like').click
        sleep 0.5
      }.to change { Like.count }.by(-1)
      expect(current_path).to eq ballot_box_rooms_path(@ballot_box)
    end
  end
  context 'いいねを削除できない' do
    it 'ログインしていないユーザー' do
      visit ballot_box_rooms_path(@ballot_box)
      expect{
        sleep 1
        find('.like').click
        sleep 0.5
      }.to change { Like.count }.by(0)
    end
  end
end

RSpec.describe "いいねの数と投票の関係", type: :system do
  before do
    @discussion = FactoryBot.create(:discussion)
    @user = @discussion.user
    @room = @discussion.room
    @ballot_box = @room.ballot_box
    Vote.create(result: @discussion.vote_result, user_id: @user.id, ballot_box_id: @ballot_box.id)
    9.times do
      user = FactoryBot.create(:user)
      Vote.create(result: 1, user_id: user.id, ballot_box_id: @ballot_box.id)
      UserRoom.create(user_id: user.id, room_id: @room.id)
      Like.create(user_id: user.id, discussion_id: @discussion.id)
    end
  end
  it 'いいねが９から10になったとき投票数が増える' do
    sign_in(@user)
    visit ballot_box_rooms_path(@ballot_box)
    expect{
      sleep 1
      find('.like').click
      sleep 0.5
    }.to change { Vote.count }.by(1)
    expect(current_path).to eq ballot_box_rooms_path(@ballot_box)
    visit ballot_box_rooms_path(@ballot_box)
    expect(page).to have_content("投票数：11")
  end
  it 'いいねが10から9になったとき投票数が減る' do
    Like.create(user_id: @user.id, discussion_id: @discussion.id)
    sign_in(@user)
    visit ballot_box_rooms_path(@ballot_box)
    expect{
      sleep 1
      find('.like').click
      sleep 0.5
    }.to change { Vote.count }.by(-1)
  end
end
