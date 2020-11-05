require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザーのアカウント新規登録のテスト' do
    context '新規登録フォームを全て正しく記入すればアカウント登録できる' do
      it 'nickname, email, passwordを正しく記入する' do
      end

      it 'passwordが数字だけ' do
      end

      it 'passwordが英字だけ' do
      end
    end
    context '新規登録フォームを異常に記入すればアカウント登録できない' do 
      it 'nicknameが空欄' do
      end

      it 'emailが空欄' do
      end

      it 'emailが既に登録されているもの' do
      end

      it 'emailに@がない' do
      end

      it 'passwordが空欄' do
      end

      it 'passwordが６文字未満' do
      end

      it 'passwordを全角で入力' do
      end

    end
  end
end