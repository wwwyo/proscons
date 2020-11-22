require 'rails_helper'

RSpec.describe BallotForm, type: :model do
  before do
    @ballot_form = FactoryBot.build(:ballot_form)
  end
  describe '投票を作成する際のフォームの記入に関するのテスト' do
    context 'フォームを正しく入力すると投票を作成できる' do
      it 'タイトル、詳細、ハッシュタグ全ての入力欄に記入する' do
        expect(@ballot_form).to be_valid
      end
      it '入力したタグが既に存在している' do
        @ballot_form.save
        ballot_form_test = FactoryBot.build(:ballot_form)
        ballot_form_test.name = @ballot_form.name
        expect(ballot_form_test).to be_valid
      end
    end
    context 'フォームを異常に入力すると投票が作成できない' do
      it 'タイトルが空欄' do
        @ballot_form.question = ''
        @ballot_form.valid?
        expect(@ballot_form.errors.full_messages).to include('質問のタイトルを入力してください')
      end
      it '詳細が空欄' do
        @ballot_form.detail = ''
        @ballot_form.valid?
        expect(@ballot_form.errors.full_messages).to include('詳細を入力してください')
      end
      it '詳細が5文字未満' do
        @ballot_form.detail = '1234'
        @ballot_form.valid?
        expect(@ballot_form.errors.full_messages).to include('詳細は5文字以上で入力してください')
      end
      it 'ハッシュタグが空欄' do
        @ballot_form.name = ''
        @ballot_form.valid?
        expect(@ballot_form.errors.full_messages).to include('ハッシュタグを入力してください')
      end
    end
  end
end
