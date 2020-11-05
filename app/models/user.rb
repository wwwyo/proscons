class User < ApplicationRecord
  has_many :ballot_boxes
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :nickname, presence: true
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  validates :password, format: { with: /\A[A-z0-9]+\z/ }
end
