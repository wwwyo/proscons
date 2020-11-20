require 'rails_helper'

RSpec.describe "アカウント作成", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'アカウント作成ができるとき' do 
    it '正しい情報を入力する時' do
      visit root_path
      click_on('アカウント作成')
      expect(current_path).to eq new_user_registration_path
      fill_in 'nickname', with: @user.nickname
      fill_in 'email', with: @user.email
      fill_in  'password', with: @user.password
      expect{click_on('登録')}.to change { User.count }.by(1)
      expect(current_path).to eq ballot_boxes_path
      find(".fa-home").click
      expect(page).to have_link('ログアウト',href: destroy_user_session_path)
      expect(page).to have_no_content('ログイン')
      expect(page).to have_no_content('アカウント作成')
    end
  end
  context 'アカウント作成ができないとき' do
    it '誤った情報ではアカウント作成ができずにアカウント作成ページへ戻ってくる' do
      visit root_path
      click_on('アカウント作成')
      expect(current_path).to eq new_user_registration_path
      expect{click_on('登録')}.to change { User.count }.by(0)
      expect(current_path).to eq user_registration_path
    end
  end
end

RSpec.describe "ログイン", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができる時' do
    it '保存されているユーザー情報と一致する時' do
      visit root_path
      click_on('ログイン')
      expect(current_path).to eq new_user_session_path
      fill_in 'email', with: @user.email
      fill_in  'password', with: @user.password
      click_on('ログイン')
      expect(current_path).to eq ballot_boxes_path
      find(".fa-home").click
      expect(page).to  have_link('ログアウト',href: destroy_user_session_path)
      expect(page).to have_no_content('ログイン')
      expect(page).to have_no_content('アカウント作成')
    end
  end
  context 'ログインができない時' do
    it '保存されているユーザー情報と一致しない時ログインページに戻る' do
      visit root_path
      click_on('ログイン')
      expect(current_path).to eq new_user_session_path
      click_on('ログイン')
      expect(current_path).to eq user_session_path
    end
  end
end

RSpec.describe "ゲストログイン", type: :system do
  it 'ゲストログインをするとログインせずに画面遷移する' do
    visit root_path
    click_on('ゲストログイン')
    expect(current_path).to eq ballot_boxes_path
    find(".fa-home").click
    expect(page).to have_link('ログイン', href: new_user_session_path)
    expect(page).to have_link('アカウント作成', href: new_user_registration_path)
    expect(page).to have_no_content('ログアウト')
  end
end

RSpec.describe "ログアウト", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  it 'ログアウトをするとゲストログインに切り替わる' do
    sign_in(@user)
    find(".fa-home").click
    click_on('ログアウト')
    expect(current_path).to eq ballot_boxes_path
    find(".fa-home").click
    expect(page).to have_link('ログイン', href: new_user_session_path)
    expect(page).to have_link('アカウント作成', href: new_user_registration_path)
    expect(page).to have_no_content('ログアウト')
  end
end
