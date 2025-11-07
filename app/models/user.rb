class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, length: { minimum: 3, maximum: 20 }
  validates :username, format: { with: /\A[a-zA-Z0-9_-]+\z/ }
end
