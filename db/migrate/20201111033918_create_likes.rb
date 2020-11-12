class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.references :user, presence: true, foreign_key: true
      t.references :discussion, presence: true, foreign_key: true
      t.timestamps
    end
  end
end
