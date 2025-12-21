class Device < ApplicationRecord
  belongs_to :category

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
end
