class CreateBallotBoxes < ActiveRecord::Migration[6.0]
  def change
    create_table :ballot_boxes do |t|
      t.string :question, null: false
      t.text :detail
      t.references :user, null:false, foreign_key: true
      t.timestamps
    end
  end
end
