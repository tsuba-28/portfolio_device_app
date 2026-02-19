class Profile < ApplicationRecord
  belongs_to :user

  has_one_attached :avatar
  has_one_attached :background

  attr_accessor :remove_avatar, :remove_background
end
