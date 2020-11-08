require 'rails_helper'

RSpec.describe Tag, type: :model do
  before do
    @tag = FactoryBot.build(:tag)
  end
  describe '投票を作成する際、タイトル、詳細を正しく記入した上で追加したタグの入力に関するテスト' do
    context '追加したタグ全ての入力欄を正しく記入すると投票を作成できる' do
      it 'ハッシュタグを追加し、全ての入力欄に記入する' do

      end
      it '追加したハッシュタグが既に存在している' do
        
      end
    end
    context '追加したタグの入力欄に空欄があると作成できない' do
      it 'ハッシュタグを追加し、追加したハッシュタグ入力欄が空欄' do
        
      end
    end
  end
end
