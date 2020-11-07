class BallotForm

  include ActiveModel::Model
  attr_accessor :question, :detail, :name, :user_id

  with_options presence: true do
    validates :question
    validates :name
  end

  def save
    ballot_box = BallotBox.create(question: question, detail: detail, user_id: user_id)
    tag = Tag.where(name: name).first_or_initialize
    tag.save
    BallotTag.create(ballot_box_id: ballot_box.id, tag_id: tag.id)
    return ballot_box.id
  end
end