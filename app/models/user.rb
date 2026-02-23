class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable

  has_one :profile, dependent: :destroy
  has_many :desk_setups, dependent: :destroy

  after_create :create_default_profile

# ログイン用仮想属性
  attr_accessor :login


# 正規表現用定数
  VALID_ALPHANUMERIC_REGEX = /\A[a-zA-Z0-9\-_]+\z/

  validates :username, presence: true,
            uniqueness: { case_sensitive: false }, #大文字小文字を区別せず重複自体を禁止
            length: { minimum: 4, maximum: 15 },
            format: { with: VALID_ALPHANUMERIC_REGEX, message: "は半角英数字([-] [_])のみ使用可能です" }

# ログイン時に下記の２つのルールに沿ってユーザーを検索
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    #フォームから送られてきた login の値を取得→一時変数に代入する
    if (login = conditions.delete(:login))
    #DBに対して、「username」または「email」にて大文字小文字無視して検索
      where(conditions.to_h).where(["lower(username) = lower(:value) OR lower(email) = lower(:value)", { value: login }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end


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
