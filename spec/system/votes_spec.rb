require 'rails_helper'

RSpec.describe "投票の実行", type: :system do
  before do
    @user = FactoryBot.create(:user)
    room = FactoryBot.create(:room)
    @vote = FactoryBot.create(:vote)
    @ballot_box = room.ballot_box
  end
  context '投票ができる時' do
    it 'ログインしており、かつまだ投票していない投票箱に賛成する' do
      sign_in(@user)
      visit ballot_box_path(@ballot_box)
      expect{click_on('賛成')}.to change { Vote.count }.by(1)
      expect(current_path).to eq ballot_box_rooms_path(@ballot_box)
      expect(page).to have_link(@ballot_box.question, href: ballot_box_path(@ballot_box))
      expect(page).to have_link(@ballot_box.question, href: ballot_box_rooms_path(@ballot_box))
      expect(page).to have_content("あなたの意見：賛成")
    end
    it 'ログインしており、かつまだ投票していない投票箱に反対する' do
      sign_in(@user)
      visit ballot_box_path(@ballot_box)
      expect{click_on('反対')}.to change { Vote.count }.by(1)
      expect(current_path).to eq ballot_box_rooms_path(@ballot_box)
      expect(page).to have_link(@ballot_box.question, href: ballot_box_path(@ballot_box))
      expect(page).to have_link(@ballot_box.question, href: ballot_box_rooms_path(@ballot_box))
      expect(page).to have_content("あなたの意見：反対")
    end
  end
  context '投票ができない時' do
    it 'ログインしているが、すでに投票済の投票箱である' do
      sign_in(@vote.user)
      visit ballot_box_path(@vote.ballot_box)
      expect(page).to have_link("チャンネルに参加する",href: ballot_box_rooms_path(@vote.ballot_box))
      expect(page).to have_no_content("賛成")
      expect(page).to have_no_content("反対")
    end
    it 'ログインしていない' do
      visit ballot_box_path(@ballot_box)
      expect(page).to have_content("チャンネルを覗く")
      expect(page).to have_no_content("賛成")
      expect(page).to have_no_content("反対")
    end
  end
end

RSpec.describe "投票の変更", type: :system do
  before do
    user_room = FactoryBot.create(:user_room)
    @ballot_box = user_room.room.ballot_box
  end
  it 'ログインしていない時、投票変更画面がない' do
    visit ballot_box_rooms_path(@ballot_box)
    expect(page).to have_no_content("あなたの意見：賛成")
    expect(page).to have_no_content("あなたの意見：反対")
  end
end
