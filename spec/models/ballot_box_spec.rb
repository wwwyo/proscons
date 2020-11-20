require 'rails_helper'

RSpec.describe BallotBox, type: :model do
  before do
    @ballot_box = FactoryBot.create(:ballot_box)
  end
  it '編集ページで補足を変更できる' do
    @ballot_box.supplement = Faker::Lorem.paragraph
    expect(@ballot_box).to be_valid
  end
end
