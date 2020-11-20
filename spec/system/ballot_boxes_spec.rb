require 'rails_helper'

RSpec.describe "BallotBoxの作成", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @ballot_box = FactoryBot.build(:ballot_box)
    @tag = FactoryBot.build(:tag)
  end
  context 'ballot_boxを作成できる時' do
    it 'ログインしたユーザーが新規投稿する' do
      sign_in(@user)
      click_on('投票を作成する')
      expect(current_path).to eq new_ballot_box_path
      fill_in 'question', with: @ballot_box.question
      fill_in 'tag', with: @tag.name
      expect{click_on('投票作成')}.to change { BallotBox.count }.by(1)
      expect(current_path).to eq ballot_boxes_path
      expect(page).to have_content(@ballot_box.question)
      expect(page).to have_content(@tag.name)
    end
  end
  context 'ballot_boxを作成できない時' do
    it 'ログインしていないとき(ゲスト)' do
      visit ballot_boxes_path
      click_on('投票を作成する')
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe "BallotBoxの編集", type: :system do
  before do
    @ballot_box1 = FactoryBot.create(:ballot_box)
    @ballot_box2 = FactoryBot.create(:ballot_box)
    @tag = FactoryBot.create(:tag)
    BallotTag.create(ballot_box_id: @ballot_box1.id, tag_id: @tag.id)
    BallotTag.create(ballot_box_id: @ballot_box2.id, tag_id: @tag.id)
  end
  context 'ballot_boxが編集できる時' do
    it 'ログインしておりかつ自分の投稿' do
      sign_in(@ballot_box1.user)
      all('.ballot_box')[1].click_on('投票する')
      expect(current_path).to eq ballot_box_path(@ballot_box1)
      click_on('編集する')
      expect(current_path).to eq edit_ballot_box_path(@ballot_box1)
    end
  end
  context 'ballot_boxを編集できない時' do
    it 'ログインしているが、自分の投稿ではない時' do
      sign_in(@ballot_box1.user)
      all('.ballot_box')[0].click_on('投票する')
      expect(current_path).to eq ballot_box_path(@ballot_box2)
      expect(page).to have_no_link('編集する', href: edit_ballot_box_path(@ballot_box2))
    end
    it 'ログインしていないとき(ゲスト)' do
      visit ballot_boxes_path
      all('.ballot_box')[0].click_on('投票する')
      expect(current_path).to eq ballot_box_path(@ballot_box2)
      expect(page).to have_no_link('編集する',href: edit_ballot_box_path(@ballot_box2))
    end
  end
end

RSpec.describe "BallotBoxのアップデート", type: :system do
  before do
    ballot_tag = FactoryBot.create(:ballot_tag)
    @ballot_box = ballot_tag.ballot_box
  end
  it 'ログインしておりかつ自分の投稿のときアップデートできる' do
    sign_in(@ballot_box.user)
    visit edit_ballot_box_path(@ballot_box)
    fill_in 'supplement', with: Faker::Lorem.paragraph
    expect{click_on('変更する')}.to change { BallotBox.count }.by(0)
    expect(current_path).to eq ballot_box_path(@ballot_box)
    have_content(@ballot_box.supplement)
  end
end

RSpec.describe "BallotBoxの削除", type: :system do
  before do
    @ballot_box1 = FactoryBot.create(:ballot_box)
    @ballot_box2 = FactoryBot.create(:ballot_box)
    @tag = FactoryBot.create(:tag)
    BallotTag.create(ballot_box_id: @ballot_box1.id, tag_id: @tag.id)
    BallotTag.create(ballot_box_id: @ballot_box2.id, tag_id: @tag.id)
  end
  context 'ballot_boxが削除できる時' do
    it 'ログインしておりかつ自分の投稿' do
      sign_in(@ballot_box1.user)
      all('.ballot_box')[1].click_on('投票する')
      expect(current_path).to eq ballot_box_path(@ballot_box1)
      expect{click_on('削除する')}.to change { BallotBox.count }.by(-1)
      expect(current_path).to eq ballot_boxes_path
      have_no_content(@ballot_box1.question)
    end
  end
  context 'ballot_boxを削除できない時' do
    it 'ログインしているが、自分の投稿ではない時' do
      sign_in(@ballot_box1.user)
      all('.ballot_box')[0].click_on('投票する')
      expect(current_path).to eq ballot_box_path(@ballot_box2)
      expect(page).to have_no_link('削除する', href: ballot_box_path(@ballot_box2))
    end
    it 'ログインしていないとき(ゲスト)' do
      visit ballot_boxes_path
      all('.ballot_box')[0].click_on('投票する')
      expect(current_path).to eq ballot_box_path(@ballot_box2)
      expect(page).to have_no_link('削除する', href: ballot_box_path(@ballot_box2))
    end
  end
end

RSpec.describe "タグの検索", type: :system do
  before do
    @ballot_box1 = FactoryBot.create(:ballot_box)
    @ballot_box2 = FactoryBot.create(:ballot_box)
    @tag1 = FactoryBot.create(:tag)
    @tag2 = FactoryBot.create(:tag)
    BallotTag.create(ballot_box_id: @ballot_box1.id, tag_id: @tag1.id)
    BallotTag.create(ballot_box_id: @ballot_box2.id, tag_id: @tag2.id)
  end
  it '検索をすると検索結果を含むのタグが表示される' do
    visit ballot_boxes_path
    fill_in 'q_name_cont', with: @tag1.name
    click_on('検索')
    expect(current_path).to eq ballot_boxes_path
    expect(page).to have_content(@ballot_box1.question)
    expect(page).to have_content(@tag1.name)
    expect(page).to have_no_content(@ballot_box2.question)
    expect(page).to have_no_content(@tag2.name)
  end
end