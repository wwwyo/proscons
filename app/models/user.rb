class User < ApplicationRecord
  has_many :ballot_boxes
  has_many :votes, dependent: :destroy
  has_many :rooms, through: :user_rooms
  has_many :user_rooms, dependent: :destroy
  has_many :discussions
  has_many :likes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :nickname, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :password, format: { with: /\A[A-z0-9]+\z/ }

  def self.guest
    find_or_create_by!(nickname: 'test_user', email: 'test@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
