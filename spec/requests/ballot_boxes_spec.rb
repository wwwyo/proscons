require 'rails_helper'

RSpec.describe 'BallotBoxes', type: :request do
  before do
    ballot_tag = FactoryBot.create(:ballot_tag)
    @ballot_box = ballot_tag.ballot_box
    @tag = ballot_tag.tag
    @user = @ballot_box.user
    Vote.create(result: 1, user_id: @user.id, ballot_box_id: @ballot_box.id)
  end

  describe 'GET #top' do
    it '正常にレスポンスが返ってくる' do
      get root_path
      expect(response.status).to eq 200
    end
  end

  describe 'GET #index' do
    it '正常にレスポンスが返ってくる' do
      get ballot_boxes_path
      expect(response.status).to eq 200
    end
    it 'レスポンスに@ballot_boxが存在する' do
      get ballot_boxes_path
      expect(response.body).to include(@ballot_box.question)
    end
    it 'レスポンスに@tagが存在する' do
      get ballot_boxes_path
      expect(response.body).to include(@tag.name)
    end
  end

  describe 'GET #popular' do
    it '正常にレスポンスが返ってくる' do
      get popular_ballot_boxes_path
      expect(response.status).to eq 200
    end
    it 'レスポンスに作成済の投票箱が存在する' do
      get popular_ballot_boxes_path
      expect(response.body).to include(@ballot_box.question)
    end
    it 'レスポンスにタグが存在する' do
      get popular_ballot_boxes_path
      expect(response.body).to include(@tag.name)
    end
  end

  describe 'GET #new' do
    context 'ログインしている時' do
      before do
        sign_in @user
      end
      it '正常にレスポンスが返ってくる' do
        get new_ballot_box_path
        expect(response.status).to eq 200
      end
    end
    context 'ログインしていない時' do
      it 'リダイレクトのレスポンスが返ってくる' do
        get new_ballot_box_path
        expect(response.status).to eq 302
      end
      it 'リダイレクト先が:sign_in' do
        get new_ballot_box_path
        expect(response.header).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST #create' do
    context 'ログインしている時' do
      before do
        sign_in @user
        @ballot_form = FactoryBot.build(:ballot_form)
      end
      it 'リダイレクトのレスポンスが返ってくる' do
        post ballot_boxes_path, params: { ballot_form: { question: @ballot_form.question, detail: @ballot_form.detail, name: @ballot_form.name } }
        expect(response.status).to eq 302
      end
      it 'リダイレクト先が:index' do
        post ballot_boxes_path, params: { ballot_form: { question: @ballot_form.question, detail: @ballot_form.detail, name: @ballot_form.name } }
        expect(response.header).to redirect_to ballot_boxes_path
      end
    end
    context 'ログインしていない時' do
      it 'リダイレクトのレスポンスが返ってくる' do
        post ballot_boxes_path
        expect(response.status).to eq 302
      end
      it 'リダイレクト先が:sign_in' do
        post ballot_boxes_path
        expect(response.header).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #show' do
    it '正常にレスポンスが返ってくる' do
      get ballot_box_path(@ballot_box)
      expect(response.status).to eq 200
    end
    it 'レスポンスに作成済の投票が存在する' do
      get ballot_box_path(@ballot_box)
      expect(response.body).to include(@ballot_box.question)
    end
    it 'レスポンスにタグが存在する' do
      get ballot_box_path(@ballot_box)
      expect(response.body).to include(@tag.name)
    end
  end

  describe 'GET #edit' do
    context 'ログインしているかつ、投票の作成者である時' do
      before do
        sign_in @user
      end
      it '正常にレスポンスが返ってくる' do
        get edit_ballot_box_path(@ballot_box)
        expect(response.status).to eq 200
      end
      it 'レスポンスに@ballot_boxが存在する' do
        get edit_ballot_box_path(@ballot_box)
        expect(response.body).to include(@ballot_box.question)
      end
      it 'レスポンスに@tagが存在する' do
        get edit_ballot_box_path(@ballot_box)
        expect(response.body).to include(@tag.name)
      end
    end
    context 'ログインしているが投票の作成者ではない時' do
      before do
        @user = FactoryBot.create(:user)
        sign_in @user
      end
      it 'リダイレクトのレスポンスが返ってくる' do
        get edit_ballot_box_path(@ballot_box)
        expect(response.status).to eq 302
      end
      it 'リダイレクト先が:show' do
        get edit_ballot_box_path(@ballot_box)
        expect(response.header).to redirect_to ballot_box_path(@ballot_box)
      end
    end
    context 'ログインしていない時' do
      it 'リダイレクトのレスポンスが返ってくる' do
        get edit_ballot_box_path(@ballot_box)
        expect(response.status).to eq 302
      end
      it 'リダイレクト先が:sign_in' do
        get edit_ballot_box_path(@ballot_box)
        expect(response.header).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #update' do
    context 'ログインしているかつ、投票の作成者である時' do
      before do
        sign_in @user
      end
      it 'リダイレクトのレスポンスが返ってくる' do
        patch ballot_box_path(@ballot_box), params: { ballot_box: { supplement: Faker::Lorem.paragraph } }
        expect(response.status).to eq 302
      end
      it 'リダイレクト先が:show' do
        patch ballot_box_path(@ballot_box), params: { ballot_box: { supplement: Faker::Lorem.paragraph } }
        expect(response.header).to redirect_to ballot_box_path(@ballot_box)
      end
    end
    context 'ログインしているが投票の作成者ではない時' do
      before do
        @user = FactoryBot.create(:user)
        sign_in @user
      end
      it 'リダイレクトのレスポンスが返ってくる' do
        patch ballot_box_path(@ballot_box)
        expect(response.status).to eq 302
      end
      it 'リダイレクト先が:show' do
        patch ballot_box_path(@ballot_box)
        expect(response.header).to redirect_to ballot_box_path(@ballot_box)
      end
    end
    context 'ログインしていない時' do
      it 'リダイレクトのレスポンスが返ってくる' do
        patch ballot_box_path(@ballot_box)
        expect(response.status).to eq 302
      end
      it 'リダイレクト先が:sign_in' do
        patch ballot_box_path(@ballot_box)
        expect(response.header).to redirect_to new_user_session_path
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'ログインしているかつ、投票の作成者である時' do
      before do
        sign_in @user
      end
      it 'リダイレクトのレスポンスが返ってくる' do
        delete ballot_box_path(@ballot_box)
        expect(response.status).to eq 302
      end
      it 'リダイレクト先が:index' do
        delete ballot_box_path(@ballot_box)
        expect(response.header).to redirect_to ballot_boxes_path
      end
    end
    context 'ログインしているが投票の作成者ではない時' do
      before do
        @user = FactoryBot.create(:user)
        sign_in @user
      end
      it 'リダイレクトのレスポンスが返ってくる' do
        delete ballot_box_path(@ballot_box)
        expect(response.status).to eq 302
      end
      it 'リダイレクト先が:show' do
        delete ballot_box_path(@ballot_box)
        expect(response.header).to redirect_to ballot_box_path(@ballot_box)
      end
    end
    context 'ログインしていない時' do
      it 'リダイレクトのレスポンスが返ってくる' do
        delete ballot_box_path(@ballot_box)
        expect(response.status).to eq 302
      end
      it 'リダイレクト先が:sign_in' do
        delete ballot_box_path(@ballot_box)
        expect(response.header).to redirect_to new_user_session_path
      end
    end
  end
end
