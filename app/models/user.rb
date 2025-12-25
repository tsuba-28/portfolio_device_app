class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_many :desk_setups, dependent: :destroy

  after_create :create_default_profile

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, length: { minimum: 3, maximum: 20 }
  validates :username, format: { with: /\A[a-zA-Z0-9_-]+\z/ }

  def avatar_image
    if profile.avatar&.attached?
      profile.avatar
    else
      'default-avatar.png'
    end
  end

  def background_image
    if profile.background&.attached?
      profile.background
    else
      'default-background.jpg'
    end
  end

  private
    def create_default_profile
      create_profile
    end
end
