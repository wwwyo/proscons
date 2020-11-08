require 'rails_helper'

RSpec.describe BallotForm, type: :model do
  before do
    @ballot_form = FactoryBot.build(:ballot_form)
  end
  describe '投票を作成する際のフォームの記入に関するのテスト' do
    context 'フォームを正しく入力すると投票を作成できる' do
      it 'タイトル、詳細、ハッシュタグ全ての入力欄に記入する'do

      end
      it '詳細を空欄、その他の入力欄全てに記入する' do

      end
      it 'ハッシュタグを追加し、全ての入力欄に記入する' do
        
      end
      it 'ハッシュタグ記入欄を追加し、詳細欄を空欄、その他の入力欄全てに記入する' do
        
      end
    end
    context 'フォームを異常に入力すると投票が作成できない' do
      it 'タイトルが空欄' do

      end
      it 'ハッシュタグが空欄' do
        
      end
      it 'ハッシュタグを追加し、追加したハッシュタグ入力欄が空欄' do
        
      end
    end

  end
end
