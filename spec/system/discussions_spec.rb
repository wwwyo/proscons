require 'rails_helper'

RSpec.describe 'チャンネル内でのコメント', type: :system do
  before do
    user_room = FactoryBot.create(:user_room)
    @user = user_room.user
    @room = user_room.room
    @ballot_box = @room.ballot_box
    @discussion = FactoryBot.build(:discussion)
  end
  context 'コメントができる時' do
    it 'ログインをしており賛成に投票している時' do
      Vote.create(result: 1, user_id: @user.id, ballot_box_id: @ballot_box.id)
      sign_in(@user)
      visit ballot_box_rooms_path(@ballot_box)
      fill_in 'discussion_comment', with: @discussion.comment
      expect  do
        click_on('投稿')
        have_content(@discussion_comment)
        have_content("#{@user_nickname}:賛成")
        have_content('いいね！')
        sleep 0.1
      end.to change { Discussion.count }.by(1)
      expect(current_path).to eq ballot_box_rooms_path(@ballot_box)
    end
    it 'ログインをしており反対に投票している時' do
      Vote.create(result: 0, user_id: @user.id, ballot_box_id: @ballot_box.id)
      sign_in(@user)
      visit ballot_box_rooms_path(@ballot_box)
      fill_in 'discussion_comment', with: @discussion.comment
      expect  do
        click_on('投稿')
        have_content(@discussion_comment)
        have_content("#{@user_nickname}:反対")
        have_content('いいね！')
        sleep 0.1
      end.to change { Discussion.count }.by(1)
      expect(current_path).to eq ballot_box_rooms_path(@ballot_box)
    end
  end
  context 'コメントができない時' do
    it 'ログインをしていない' do
      visit ballot_box_rooms_path(@ballot_box)
      expect(page).to have_link('コメントするにはログインしてください', href: new_user_session_path)
      expect(page).to have_no_link('投稿', href: ballot_box_room_discussions_path(@ballot_box, @room))
    end
  end
end
