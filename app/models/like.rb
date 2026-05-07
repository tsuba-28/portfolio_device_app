class Like < ApplicationRecord
  belongs_to :user
  belongs_to :desk_setup

  validates :user_id, uniqueness: { scope: :desk_setup_id }
end
