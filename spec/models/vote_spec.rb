require 'rails_helper'

RSpec.describe Vote, type: :model do
  before do
    @vote = FactoryBot.build(:vote)
  end
  describe 'ballot_boxに対して賛成または反対を投票できる' do
    it 'resultに1が入っていると保存される' do
      expect(@vote).to be_valid
    end
    it 'resultに0が入っていると保存される' do
      @vote.result = "0"
      expect(@vote).to be_valid
    end
  end
end
