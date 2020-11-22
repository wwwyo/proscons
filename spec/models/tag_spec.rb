require 'rails_helper'

RSpec.describe Tag, type: :model do
  before do
    @tag = FactoryBot.build(:tag)
  end
  describe '投票を作成する際、タイトル、詳細を正しく記入した上で追加したタグの入力に関するテスト' do
    context '追加したタグ全ての入力欄を正しく記入すると投票を作成できる' do
      it 'ハッシュタグを追加し、全ての入力欄に記入する' do
        expect(@tag).to be_valid
      end
      it '追加したハッシュタグが既に存在している' do
        @tag.save
        expect(@tag).to be_valid
      end
    end
    context '追加したタグの入力欄に空欄があると作成できない' do
      it 'ハッシュタグを追加し、追加したハッシュタグ入力欄が空欄' do
        @tag.name = ''
        @tag.valid?
        expect(@tag.errors.full_messages).to include('ハッシュタグを入力してください')
      end
    end
  end
end
