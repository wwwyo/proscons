class AddBallotBoxes < ActiveRecord::Migration[6.0]
  def change
    add_column :ballot_boxes, :supplement, :text, after: :detail
  end
end
