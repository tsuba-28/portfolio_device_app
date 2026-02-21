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
            presence: true,
            format: { with: VALID_ALPHANUMERIC_REGEX, message: "は半角英数字([-] [_])のみ使用可能です" }

  validates :usertag,
            presence: true,
            length: { minimum: 4, maximum: 15 },
            format: { with: VALID_ALPHANUMERIC_REGEX, message: "は半角英数字([-] [_])のみ使用可能です" },
            uniqueness: { scope: :username, message: "とユーザー名の組み合わせは既に存在しています\n別のタグをお試しください" }

  def display_id
    "@#{username}##{usertag}"
  end

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
