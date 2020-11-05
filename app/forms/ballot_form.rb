class BallotForm

  include ActiveModel::Model
  attr_accessor :question, :detail, :name, :user_id

  with_options presence: true do
    validates :question
    validates :name
  end

  def save
    ballot_box = BallotBox.create(question: question, detail: detail, user_id: user_id)
    tag = Tag.create(name: name)
    BallotTag.create(ballot_box_id: ballot_box.id, tag_id: tag.id)
  end
end