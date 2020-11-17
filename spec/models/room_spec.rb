require 'rails_helper'

RSpec.describe Room, type: :model do
  before do
    @room = FactoryBot.build(:room)
  end
  describe 'roomの作成' do
    it 'ballot_boxが存在する時、保存できる' do
      expect(@room).to be_valid
    end
  end
end
