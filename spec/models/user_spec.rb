require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザーのアカウント新規登録のテスト' do
    context '新規登録フォームを全て正しく記入すればアカウント登録できる' do
      it 'nickname, email, passwordを正しく記入する' do
        expect(@user).to be_valid
      end

      it 'passwordが数字だけ' do
        @user.password = "123456"
        expect(@user).to be_valid
      end

      it 'passwordが英字だけ' do
        @user.password = "abcdef"
        expect(@user).to be_valid
      end
    end

    context '新規登録フォームを異常に記入すればアカウント登録できない' do 
      it 'nicknameが空欄' do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it 'emailが空欄' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
      end

      it 'emailが既に登録されているもの' do
        @user.save
        user_test = FactoryBot.build(:user)
        user_test.email = @user.email
        user_test.valid?
        expect(user_test.errors.full_messages).to include("メールアドレスはすでに存在します")
      end

      it 'emailに@がない' do
        @user.email = "emailgmial.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスは不正な値です")
      end

      it 'passwordが空欄' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end

      it 'passwordが６文字未満' do
        @user.password = "12345"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end

      it 'passwordを全角で入力' do
        @user.password = "１２３４５６"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
    end
  end
end