require 'test_helper'

class BallotBoxesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get ballot_boxes_index_url
    assert_response :success
  end
end
