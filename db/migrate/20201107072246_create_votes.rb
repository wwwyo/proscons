class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.boolean :result, null: false
      t.references :user, null: false, foreign_key: true
      t.references :ballot_box, null: false, foreign_key: true
      t.timestamps
    end
  end
end
