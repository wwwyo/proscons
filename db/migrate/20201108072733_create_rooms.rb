class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.references :ballot_box, null: false, foreign_key: true
      t.timestamps
    end
  end
end
