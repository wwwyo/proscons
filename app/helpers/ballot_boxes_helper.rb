module BallotBoxesHelper
  def created_date
    @ballot_box.created_at.strftime('%Y/%m/%d')
  end

  def question
    @ballot_box.question
  end

  def detail
    @ballot_box.detail
  end

  def supplement
    @ballot_box.supplement 
  end
end
