class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_many :desk_setups, dependent: :destroy

  after_create :create_default_profile
# 正規表現用定数
  VALID_ALPHANUMERIC_REGEX = /\A[a-zA-Z0-9\-_]+\z/

  validates :username, presence: true,
            uniqueness: true,
            length: { minimum: 4, maximum: 15 },
            format: { with: VALID_ALPHANUMERIC_REGEX, message: "は半角英数字([-] [_])のみ使用可能です" }


  def avatar_image
    if profile&.avatar&.attached?
      profile.avatar
    else
      'default-avatar.png'
    end
  end

  def background_image
    if profile&.background&.attached?
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
