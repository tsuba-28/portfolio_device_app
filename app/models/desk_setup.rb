class DeskSetup < ApplicationRecord
  belongs_to :user

  has_many_attached :images

  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 500 }
end
