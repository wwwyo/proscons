class CreateDiscussions < ActiveRecord::Migration[6.0]
  def change
    create_table :discussions do |t|
      t.text :comment, null: false
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.references :vote, null: false, foreign_key: true
      t.timestamps
    end
  end
end
