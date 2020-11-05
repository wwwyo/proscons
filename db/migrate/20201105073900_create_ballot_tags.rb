class CreateBallotTags < ActiveRecord::Migration[6.0]
  def change
    create_table :ballot_tags do |t|

      t.timestamps
    end
  end
end
