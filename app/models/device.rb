class Device < ApplicationRecord
  belongs_to :category

  has_many :desk_setup_devices, dependent: :destroy
  has_many :desk_setups, through: :desk_setup_devices

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
end
