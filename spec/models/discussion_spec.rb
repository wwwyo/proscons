require 'rails_helper'

RSpec.describe Discussion, type: :model do
  before do
    @discussion = FactoryBot.build(:discussion)
  end
  describe 'コメント投稿機能' do
    context 'コメントを正しく記入したとき投稿できる' do
      it '賛成意見の人がコメント欄に記入して投稿' do
        expect(@discussion).to be_valid
      end
      it  '反対意見の人がコメント欄を記入して投稿できる' do
        @discussion.vote_result = false
        expect(@discussion).to be_valid
      end
    end
    context 'コメントを以上に記入したとき投稿できない' do
      it '賛成意見の人がコメント欄を空白で投稿' do
        @discussion.comment = ""
        @discussion.valid?
        expect(@discussion.errors.full_messages).to include("コメントを入力してください")
      end
      it '反対意見の人がコメント欄を空白で投稿' do
        @discussion.vote_result = false
        @discussion.comment = ""
        @discussion.valid?
        expect(@discussion.errors.full_messages).to include("コメントを入力してください")
      end
    end
  end
end
