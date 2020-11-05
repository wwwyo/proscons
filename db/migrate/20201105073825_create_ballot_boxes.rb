class CreateBallotBoxes < ActiveRecord::Migration[6.0]
  def change
    create_table :ballot_boxes do |t|

      t.timestamps
    end
  end
end
