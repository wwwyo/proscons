require 'rails_helper'

RSpec.describe "チャンネルの退出", type: :system do
  before do
    user_room = FactoryBot.create(:user_room)
    @user = user_room.user
    @room = user_room.room
    @ballot_box = @room.ballot_box
    Vote.create(result: 1, user_id: @user.id, ballot_box_id: @ballot_box.id)
  end
  context 'チャンネル退出できる時' do
    it 'ログインしていると、参加しているチャンネルから退出できる。' do
      sign_in(@user)
      visit ballot_box_rooms_path(@ballot_box)
      find('.info').click
      expect{click_on('このチャンネルから退出')}.to change { UserRoom.count }.by(-1)
      expect(current_path).to eq ballot_boxes_path
      expect(page).to have_no_link(@ballot_box_question, href: ballot_box_rooms_path(@ballot_box))
    end
  end
  context 'チャンネル退出できない時' do
    it 'ログインしていないとチャンネル退出ボタンがない' do
      visit ballot_box_rooms_path(@ballot_box)
      find('.info').click
      expect(page).to have_no_link('このチャンネルから退出', href: ballot_box_room_path(@ballot_box, @room))
    end
  end
end

RSpec.describe "チャンネルの再入室", type: :system do
  before do
    vote = FactoryBot.create(:vote)
    @user = vote.user
    @ballot_box = vote.ballot_box
    Room.create(ballot_box_id: @ballot_box.id)
  end
  context 'チャンネルに再入室できる時' do
    it 'ログインしていると、退会したチャンネルに再参加できる。' do
      sign_in(@user)
      visit ballot_box_path(@ballot_box)
      expect{click_on('チャンネルに参加する')}.to change { UserRoom.count }.by(1)
      expect(current_path).to eq ballot_box_rooms_path(@ballot_box)
      expect(page).to have_link(@ballot_box_question, href: ballot_box_rooms_path(@ballot_box))
    end
  end
  context 'チャンネル再入室できない時' do
    it 'ログインしていないとチャンネル参加ボタンがない' do
      visit ballot_box_path(@ballot_box)
      expect(page).to have_no_link('このチャンネルに参加する', href: ballot_box_rooms_path(@ballot_box))
    end
  end
end