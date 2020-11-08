class Room < ApplicationRecord
  has_many :users, through: :user_rooms
  has_many :usre_rooms, dependent: :destroy
  belongs_to :ballot_box
end
