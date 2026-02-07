class DeskSetup < ApplicationRecord
  acts_as_taggable 

  belongs_to :user
  belongs_to :style

  has_many :desk_setup_devices, dependent: :destroy
  has_many :devices, through: :desk_setup_devices

  has_many_attached :images

  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 500 }
end
