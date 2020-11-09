class User < ApplicationRecord
  has_many :ballot_boxes
  has_many :votes, dependent: :destroy
  has_many :rooms, through: :user_rooms
  has_many :user_rooms, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :nickname, presence: true
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  validates :password, format: { with: /\A[A-z0-9]+\z/ }
end
